<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
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
  com.tecsup.lab05.model.entities.Administrador adm = (com.tecsup.lab05.model.entities.Administrador) misesion.getAttribute("eladministrador");
  String nombre = adm.getNombres() + " " + adm.getApellidos();

  String sid = request.getParameter("id");
  PeriodoDao dao = DaoFactory.getPeriodoDao(Util.opc);
  PeriodoAcademico periodo = dao.find(Integer.parseInt(sid));
%>
<head><meta charset="UTF-8"><title>Eliminar Periodo - <%=nombre%></title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <h3>Eliminar Periodo</h3>
  <form action="pController" method="get">
    <div class="mb-2">
      <label>ID</label>
      <input class="form-control" type="text" readonly value="<%=periodo.getIdPeriodo()%>" name="txtIdPeriodo">
    </div>
    <div class="mb-2">
      <label>Nombre</label>
      <input class="form-control" type="text" readonly value="<%=periodo.getNombrePeriodo()%>">
    </div>
    <div class="mb-2">
      <label>Fecha Inicio</label>
      <input class="form-control" type="text" readonly value="<%=periodo.getFechaInicio()%>">
    </div>
    <div class="mb-2">
      <label>Fecha Fin</label>
      <input class="form-control" type="text" readonly value="<%=periodo.getFechaFin()%>">
    </div>

    <input type="hidden" name="accion" value="eliminar" />
    <div class="d-flex gap-2">
      <button class="btn btn-danger" type="submit">Eliminar</button>
      <a class="btn btn-secondary" href="periodoMan.jsp">Regresar</a>
    </div>
  </form>
</div>
</body>
</html>
