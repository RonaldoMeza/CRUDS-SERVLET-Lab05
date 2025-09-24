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

@WebServlet(name = "MatriculaController", urlPatterns = {"/matriculaController", "/mController"})
public class MatriculaController extends HttpServlet {

    private MatriculaService servicio = new MatriculaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        System.out.println("[MatriculaController] doGet - accion=" + accion + " - params: idMatricula="
                + request.getParameter("idMatricula") + ", chrAluCodigo=" + request.getParameter("chrAluCodigo"));

        try {
            if ("create".equalsIgnoreCase(accion)) {
                // crear matrícula transaccionalmente
                String chrAluCodigo = request.getParameter("chrAluCodigo");
                int idPeriodo = Integer.parseInt(request.getParameter("idPeriodo"));
                String[] cursos = request.getParameterValues("cursos");
                java.util.List<String> listaCursos = cursos != null ? java.util.Arrays.asList(cursos) : new java.util.ArrayList<>();
                int newId = servicio.crearMatriculaConCursos(chrAluCodigo, idPeriodo, listaCursos);
                System.out.println("[MatriculaController] create -> nueva matricula id=" + newId);
            } else if ("actualizar".equalsIgnoreCase(accion)) {
                // actualizar matrícula
                Matricula m = new Matricula();
                String sid = request.getParameter("idMatricula") != null ? request.getParameter("idMatricula") : request.getParameter("id");
                m.setIdMatricula(Integer.parseInt(sid));
                m.setChrAluCodigo(request.getParameter("chrAluCodigo"));
                m.setIdPeriodo(Integer.parseInt(request.getParameter("idPeriodo")));
                m.setEstado(request.getParameter("estado"));
                servicio.actualizar(m);
                System.out.println("[MatriculaController] actualizar -> id=" + m.getIdMatricula());
            } else if ("retirar".equalsIgnoreCase(accion)) {
                // retirar matrícula (baja lógica)
                String sid = request.getParameter("idMatricula") != null ? request.getParameter("idMatricula") : request.getParameter("id");
                System.out.println("[MatriculaController] RETIRAR - recibido idMatricula=" + sid);
                int idMat = Integer.parseInt(sid);
                servicio.eliminar(idMat);
                System.out.println("[MatriculaController] RETIRAR - servicio.eliminar completado para id=" + idMat);
            } else {
                System.out.println("[MatriculaController] Accion no reconocida o nula: " + accion);
            }
        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            request.setAttribute("error", "Parámetro numérico inválido: " + nfe.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        } catch (Exception ex) {
            // log completo y forward a error.jsp con la traza
            ex.printStackTrace();
            java.io.StringWriter sw = new java.io.StringWriter();
            ex.printStackTrace(new java.io.PrintWriter(sw));
            request.setAttribute("error", sw.toString());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // redirigir al listado siempre que no hayamos hecho forward por error
        response.sendRedirect("matriculaMan.jsp");
    }
}
