<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.services.MatriculaService" %>
<%@ page import="com.tecsup.lab05.services.Impl.MatriculaServiceImpl" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if (misesion.getAttribute("eladministrador") == null) {
    response.sendRedirect("error.jsp");
  } else {
    Administrador adm = (Administrador) misesion.getAttribute("eladministrador");
    String nombre = adm.getNombres() + " " + adm.getApellidos();
    String sid = request.getParameter("id");
    com.tecsup.lab05.model.daos.MatriculaDao dao = com.tecsup.lab05.model.daos.Impl.DaoFactory.getMatriculaDao(com.tecsup.lab05.util.Util.opc);
    Matricula m = dao.find(Integer.parseInt(sid));
%>
<head>
  <meta charset="UTF-8">
  <title>Actualizar Matrícula - <%=nombre%></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-6 mx-auto">
    <div class="card text-center">
      <div class="card-header"><h3>ACTUALIZAR MATRÍCULA</h3></div>
      <div class="card-body">
        <form action="mController">
          <input type="hidden" name="idMatricula" value="<%=m.getIdMatricula()%>"/>
          <div class="input-group mt-2">
            <label class="input-group-text">Alumno (codigo)</label>
            <input class="form-control" type="text" name="chrAluCodigo" required value="<%=m.getChrAluCodigo()%>">
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Periodo</label>
            <input class="form-control" type="text" name="idPeriodo" required value="<%=m.getIdPeriodo()%>">
            <!-- si prefieres, reemplaza por select con periodos -->
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Estado</label>
            <select name="estado" class="form-control">
              <option value="activo" <%= "activo".equals(m.getEstado()) ? "selected" : "" %>>activo</option>
              <option value="retirado" <%= "retirado".equals(m.getEstado()) ? "selected" : "" %>>retirado</option>
              <option value="anulado" <%= "anulado".equals(m.getEstado()) ? "selected" : "" %>>anulado</option>
            </select>
          </div>

          <div class="form-group mt-4 d-grid gap-2">
            <input type="hidden" name="accion" value="actualizar"/>
            <input class="btn btn-success" type="submit" value="Actualizar"/>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
<% } %>
</html>
