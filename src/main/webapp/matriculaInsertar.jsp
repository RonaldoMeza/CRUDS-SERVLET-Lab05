<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.CursoDao" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.entities.Curso" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if(misesion.getAttribute("eladministrador")==null){
    response.sendRedirect("error.jsp");
  }
  com.tecsup.lab05.model.daos.PeriodoDao periodoDao = com.tecsup.lab05.model.daos.Impl.DaoFactory.getPeriodoDao(com.tecsup.lab05.util.Util.opc);
  com.tecsup.lab05.model.daos.CursoDao cursoDao = com.tecsup.lab05.model.daos.Impl.DaoFactory.getCursoDao(com.tecsup.lab05.util.Util.opc);
  java.util.List<PeriodoAcademico> periodos = periodoDao.findAll();
  java.util.List<Curso> cursos = cursoDao.findAll();
%>
<head><meta charset="UTF-8"><title>Nueva Matrícula</title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-8 mx-auto">
    <div class="card">
      <div class="card-header text-center"><h3>CREAR MATRÍCULA</h3></div>
      <div class="card-body">
        <form action="mController">
          <div class="input-group mt-2">
            <label class="input-group-text">Alumno (codigo)</label>
            <input class="form-control" type="text" name="chrAluCodigo" required placeholder="Ejm: A0001">
            <!-- Si tienes listado de alumnos, reemplaza input por select -->
          </div>

          <div class="input-group mt-2">
            <label class="input-group-text">Periodo</label>
            <select name="idPeriodo" class="form-control" required>
              <% for (PeriodoAcademico p : periodos) { %>
              <option value="<%=p.getIdPeriodo()%>"><%=p.getNombrePeriodo()%></option>
              <% } %>
            </select>
          </div>

          <div class="mt-3">
            <label class="form-label">Cursos (selecciona uno o varios)</label>
            <div class="row">
              <% for (Curso c : cursos) { %>
              <div class="col-md-4">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="cursos" value="<%=c.getCodigo()%>" id="cur<%=c.getCodigo()%>">
                  <label class="form-check-label" for="cur<%=c.getCodigo()%>"><%=c.getNombre()%> (<%=c.getCodigo()%>)</label>
                </div>
              </div>
              <% } %>
            </div>
          </div>

          <div class="form-group mt-4 d-grid gap-2">
            <input type="hidden" name="accion" value="create"/>
            <input class="btn btn-success" type="submit" value="Matricular"/>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
