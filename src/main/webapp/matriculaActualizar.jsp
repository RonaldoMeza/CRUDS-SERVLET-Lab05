<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.entities.Alumno" %>
<%@ page import="com.tecsup.lab05.model.daos.MatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.AlumnoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
<%@ page import="com.tecsup.lab05.util.Util" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if (misesion.getAttribute("eladministrador") == null) {
    response.sendRedirect("error.jsp");
    return;
  }
  Administrador adm = (Administrador) session.getAttribute("eladministrador");
  String nombreAdmin = adm.getNombres() + " " + adm.getApellidos();

  // Parámetro id que viene en la URL (ej: matriculaActualizar.jsp?id=3)
  String sid = request.getParameter("id");
  if (sid == null || sid.trim().isEmpty()) {
    // si no hay id, redirigir al listado
    response.sendRedirect("matriculaMan.jsp");
    return;
  }

  int idMat = 0;
  try {
    idMat = Integer.parseInt(sid);
  } catch (NumberFormatException e) {
    response.sendRedirect("matriculaMan.jsp");
    return;
  }

  // cargar matrícula
  MatriculaDao mDao = DaoFactory.getMatriculaDao(Util.opc);
  Matricula matricula = mDao.find(idMat);
  if (matricula == null) {
    // no existe -> volver al listado
    response.sendRedirect("matriculaMan.jsp");
    return;
  }

  // cargar periodos y alumnos para selects
  PeriodoDao pDao = DaoFactory.getPeriodoDao(Util.opc);
  java.util.List<PeriodoAcademico> periodos = pDao.findAll();

  AlumnoDao aDao = DaoFactory.getAlumnoDao(Util.opc);
  java.util.List<Alumno> alumnos = aDao.findAll();
%>
<head>
  <meta charset="UTF-8">
  <title>Editar Matrícula - <%= nombreAdmin %></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <div class="row">
    <div class="col-md-8 mx-auto">
      <div class="card p-3">
        <div class="card-header">
          <h3>Actualizar Matrícula</h3>
        </div>
        <div class="card-body">
          <form action="matriculaController" method="get">
            <input type="hidden" name="idMatricula" value="<%= matricula.getIdMatricula() %>" />
            <input type="hidden" name="accion" value="actualizar" />

            <div class="mb-2">
              <label class="form-label">Alumno</label>
              <select name="chrAluCodigo" class="form-control" required>
                <option value="">--Seleccionar alumno--</option>
                <% for (Alumno a : alumnos) {
                  String code = a.getCodigo();
                %>
                <option value="<%= code %>" <%= code.equals(matricula.getChrAluCodigo()) ? "selected" : "" %>>
                  <%= a.getNombres() %> <%= a.getApellidos() %> (<%= code %>)
                </option>
                <% } %>
              </select>
            </div>

            <div class="mb-2">
              <label class="form-label">Periodo</label>
              <select name="idPeriodo" class="form-control" required>
                <option value="">--Seleccionar periodo--</option>
                <% for (PeriodoAcademico p : periodos) {
                  int pid = p.getIdPeriodo();
                %>
                <option value="<%= pid %>" <%= pid == matricula.getIdPeriodo() ? "selected" : "" %>>
                  <%= p.getNombrePeriodo() %>
                </option>
                <% } %>
              </select>
            </div>

            <div class="mb-2">
              <label class="form-label">Estado</label>
              <select name="estado" class="form-control" required>
                <option value="activo" <%= "activo".equals(matricula.getEstado()) ? "selected" : "" %>>activo</option>
                <option value="retirado" <%= "retirado".equals(matricula.getEstado()) ? "selected" : "" %>>retirado</option>
              </select>
            </div>

            <div class="d-flex gap-2 mt-3">
              <button class="btn btn-success" type="submit">Guardar</button>
              <a class="btn btn-secondary" href="matriculaMan.jsp">Regresar</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
