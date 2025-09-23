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
  <title>Eliminar Periodo - <%=nombre%></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-6 mx-auto">
    <div class="card text-center">
      <div class="card-header"><h3>ELIMINAR PERIODO</h3></div>
      <div class="card-body">
        <form action="pController">
          <div class="input-group mt-2">
            <label class="input-group-text">ID</label>
            <input class="form-control" type="text" name="txtIdPeriodo" readonly value="<%=periodo.getIdPeriodo()%>"/>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Nombre</label>
            <input class="form-control" type="text" readonly value="<%=periodo.getNombrePeriodo()%>"/>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Inicio</label>
            <input class="form-control" type="text" readonly value="<%=periodo.getFechaInicio()%>"/>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Fin</label>
            <input class="form-control" type="text" readonly value="<%=periodo.getFechaFin()%>"/>
          </div>
          <div class="form-group mt-4 d-grid gap-2">
            <input type="hidden" name="accion" value="eliminar"/>
            <input class="btn btn-danger" type="submit" value="Eliminar"/>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
<% } %>
</html>
