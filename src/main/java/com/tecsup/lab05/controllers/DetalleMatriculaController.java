package com.tecsup.lab05.controllers;

import com.tecsup.lab05.model.entities.DetalleMatricula;
import com.tecsup.lab05.services.DetalleMatriculaService;
import com.tecsup.lab05.services.Impl.DetalleMatriculaServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DetalleMatriculaController", urlPatterns = {"/detalleMatriculaController", "/dController"})
public class DetalleMatriculaController extends HttpServlet {

    private DetalleMatriculaService detalleService = new DetalleMatriculaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        try {
            if ("retirar".equals(accion)) {
                // retirar detalle: recibe idDetalle y opcional idMatricula para volver al listado
                int idDetalle = Integer.parseInt(request.getParameter("idDetalle"));
                String sidMat = request.getParameter("idMatricula"); // opcional, para redirect
                detalleService.eliminar(idDetalle); // en DAO hace sp_retirar_detalle
                if (sidMat != null && !sidMat.isEmpty()) {
                    response.sendRedirect("detalleMatriculaMan.jsp?idMatricula=" + sidMat);
                } else {
                    response.sendRedirect("detalleMatriculaMan.jsp");
                }
                return;
            }

            if ("create".equals(accion)) {
                // inserta un detalle simple (ej: desde un formulario con idMatricula y chrCurCodigo)
                int idMatricula = Integer.parseInt(request.getParameter("idMatricula"));
                String chrCurCodigo = request.getParameter("chrCurCodigo");

                DetalleMatricula d = new DetalleMatricula();
                d.setIdMatricula(idMatricula);
                d.setChrCurCodigo(chrCurCodigo);
                d.setEstado("matriculado");
                detalleService.grabar(d);

                response.sendRedirect("detalleMatriculaMan.jsp?idMatricula=" + idMatricula);
                return;
            }

            // lista por idMatricula (si se usa)
            if ("listar".equals(accion)) {
                String sidMat = request.getParameter("idMatricula");
                if (sidMat != null && !sidMat.isEmpty()) {
                    response.sendRedirect("detalleMatriculaMan.jsp?idMatricula=" + sidMat);
                    return;
                } else {
                    response.sendRedirect("detalleMatriculaMan.jsp");
                    return;
                }
            }

        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "Parámetro numérico inválido: " + nfe.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        } catch (Exception ex) {
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // por defecto, redirige al listado
        response.sendRedirect("detalleMatriculaMan.jsp");
    }
}
