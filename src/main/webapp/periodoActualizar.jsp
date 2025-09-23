<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.services.PeriodoService" %>
<%@ page import="com.tecsup.lab05.services.Impl.PeriodoServiceImpl" %>
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
    PeriodoService servicio = new PeriodoServiceImpl();
    PeriodoAcademico periodo = servicio.buscar(Integer.parseInt(sid));
%>
<head>
  <meta charset="UTF-8">
  <title>Actualizar Periodo - <%=nombre%></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-6 mx-auto">
    <div class="card text-center">
      <div class="card-header"><h3>ACTUALIZAR PERIODO</h3></div>
      <div class="card-body">
        <form action="pController">
          <input type="hidden" name="txtIdPeriodo" value="<%=periodo.getIdPeriodo()%>"/>
          <div class="input-group mt-2">
            <label class="input-group-text">Nombre</label>
            <input class="form-control" type="text" name="txtNombre" required value="<%=periodo.getNombrePeriodo()%>">
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Inicio</label>
            <input class="form-control" type="date" name="txtFechaInicio"
                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(periodo.getFechaInicio()) %>" required>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Fin</label>
            <input class="form-control" type="date" name="txtFechaFin"
                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(periodo.getFechaFin()) %>" required>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Estado</label>
            <select name="txtEstado" class="form-control">
              <option value="abierto" <%= "abierto".equals(periodo.getEstado()) ? "selected" : "" %>>abierto</option>
              <option value="cerrado" <%= "cerrado".equals(periodo.getEstado()) ? "selected" : "" %>>cerrado</option>
              <option value="inactivo" <%= "inactivo".equals(periodo.getEstado()) ? "selected" : "" %>>inactivo</option>
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
