<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.services.PeriodoService" %>
<%@ page import="com.tecsup.lab05.services.Impl.PeriodoServiceImpl" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if(misesion.getAttribute("eladministrador")==null){
    response.sendRedirect("error.jsp");
  }else{
    com.tecsup.lab05.model.entities.Administrador adm = (Administrador)misesion.getAttribute("eladministrador");
    String nombre = adm.getNombres() + " " + adm.getApellidos();
    PeriodoService servicio = new PeriodoServiceImpl();
%>
<head>
  <meta charset="UTF-8">
  <title>Periodos - <%=nombre%></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <h1>Periodos Académicos</h1>
  <div style="padding:10px;">
    <a class="btn btn-danger" href="periodoInsertar.jsp">Nuevo Periodo</a>
  </div>
  <table class="table table-dark table-hover">
    <tr align="center">
      <th>ID</th>
      <th>NOMBRE</th>
      <th>FECHA INI</th>
      <th>FECHA FIN</th>
      <th>ESTADO</th>
      <th>ACCIONES</th>
    </tr>
    <% for (PeriodoAcademico p : servicio.listar()) { %>
    <tr>
      <td><%=p.getIdPeriodo()%></td>
      <td><%=p.getNombrePeriodo()%></td>
      <td><%=p.getFechaInicio()%></td>
      <td><%=p.getFechaFin()%></td>
      <td><%=p.getEstado()%></td>
      <td>
        <a class="btn btn-warning" href="periodoActualizar.jsp?id=<%=p.getIdPeriodo()%>">Actualizar</a>
        <a class="btn btn-danger" href="periodoEliminar.jsp?id=<%=p.getIdPeriodo()%>">Eliminar</a>
      </td>
    </tr>
    <% } %>
  </table>
</div>
</body>
<% } %>
</html>
