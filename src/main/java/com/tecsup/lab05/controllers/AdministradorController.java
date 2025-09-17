package com.tecsup.lab05.controllers;

import com.tecsup.lab05.model.entities.Administrador;
import com.tecsup.lab05.services.AdministradorService;
import com.tecsup.lab05.services.Impl.AdministradorServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdministradorController", urlPatterns = {"/sValidador", "/admin"})
public class AdministradorController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sUsuario = request.getParameter("txtUsuario");
        String sPassword = request.getParameter("txtPassword");

        AdministradorService servicio = new AdministradorServiceImpl();

        Administrador adm = servicio.validar(sUsuario, sPassword);

        if(adm != null){
            request.getSession().setAttribute("eladministrador", adm);
            response.sendRedirect("principal.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}