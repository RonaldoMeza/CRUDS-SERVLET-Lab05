package com.tecsup.lab05.controllers;

import com.tecsup.lab05.model.entities.PeriodoAcademico;
import com.tecsup.lab05.services.PeriodoService;
import com.tecsup.lab05.services.Impl.PeriodoServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet(name = "PeriodoController", urlPatterns = {"/periodoController", "/pController"})
public class PeriodoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PeriodoAcademico p = new PeriodoAcademico();
        p.setNombrePeriodo(request.getParameter("txtNombre"));
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (request.getParameter("txtFechaInicio") != null && !request.getParameter("txtFechaInicio").isEmpty())
                p.setFechaInicio(sdf.parse(request.getParameter("txtFechaInicio")));
            if (request.getParameter("txtFechaFin") != null && !request.getParameter("txtFechaFin").isEmpty())
                p.setFechaFin(sdf.parse(request.getParameter("txtFechaFin")));
        } catch (Exception e) {
            System.out.println("Fecha inválida: " + e.getMessage());
        }
        p.setEstado(request.getParameter("txtEstado"));

        PeriodoService servicio = new PeriodoServiceImpl();
        String accion = request.getParameter("accion");
        switch (accion) {
            case "insertar":
                servicio.grabar(p);
                break;
            case "actualizar":
                try {
                    p.setIdPeriodo(Integer.parseInt(request.getParameter("txtIdPeriodo")));
                    servicio.actualizar(p);
                } catch (NumberFormatException nfe) {
                    System.out.println("Id inválido");
                }
                break;
            case "eliminar":
                try {
                    int id = Integer.parseInt(request.getParameter("txtIdPeriodo"));
                    servicio.eliminar(id);
                } catch (NumberFormatException nfe) {
                    System.out.println("Id inválido");
                }
                break;
        }
        response.sendRedirect("periodoMan.jsp");
    }
}
