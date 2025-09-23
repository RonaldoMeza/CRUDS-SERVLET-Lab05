package com.tecsup.lab05.controllers;

import com.tecsup.lab05.model.entities.Matricula;
import com.tecsup.lab05.services.MatriculaService;
import com.tecsup.lab05.services.Impl.MatriculaServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "MatriculaController", urlPatterns = {"/matriculaController", "/mController"})
public class MatriculaController extends HttpServlet {

    private MatriculaService servicio = new MatriculaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("create".equals(accion)) {
                String chrAluCodigo = request.getParameter("chrAluCodigo");
                int idPeriodo = Integer.parseInt(request.getParameter("idPeriodo"));
                String[] cursos = request.getParameterValues("cursos"); // checkboxes o multi-select
                List<String> listaCursos = cursos != null ? Arrays.asList(cursos) : new ArrayList<>();
                servicio.crearMatriculaConCursos(chrAluCodigo, idPeriodo, listaCursos);
            } else if ("actualizar".equals(accion)) {
                Matricula m = new Matricula();
                m.setIdMatricula(Integer.parseInt(request.getParameter("idMatricula") != null
                        ? request.getParameter("idMatricula") : request.getParameter("id")));
                m.setChrAluCodigo(request.getParameter("chrAluCodigo"));
                m.setIdPeriodo(Integer.parseInt(request.getParameter("idPeriodo")));
                m.setEstado(request.getParameter("estado"));
                servicio.actualizar(m);
            } else if ("retirar".equals(accion)) {
                // debug: registrar entrada
                System.out.println("[MatriculaController] RETIRAR - inicio. params: idMatricula=" + request.getParameter("idMatricula"));

                try {
                    int idMat = Integer.parseInt(request.getParameter("idMatricula"));
                    servicio.eliminar(idMat); // llama al DAO -> SP
                    System.out.println("[MatriculaController] RETIRAR - servicio.eliminar() completado para id=" + idMat);

                    // redirect explícito y terminar
                    response.sendRedirect("matriculaMan.jsp");
                    return;
                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    request.setAttribute("error", "Id inválido: " + nfe.getMessage());
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                } catch (Exception ex) {
                    // captura la traza completa en un String para poder verla en el JSP y en consola
                    ex.printStackTrace();
                    java.io.StringWriter sw = new java.io.StringWriter();
                    ex.printStackTrace(new java.io.PrintWriter(sw));
                    request.setAttribute("error", sw.toString());
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
            }
            else {
                // acción no reconocida — opcional
            }
        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "Parámetro numérico inválido: " + nfe.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        response.sendRedirect("matriculaMan.jsp");
    }
}
