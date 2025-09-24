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
  com.tecsup.lab05.model.entities.Administrador adm = (com.tecsup.lab05.model.entities.Administrador) session.getAttribute("eladministrador");
  String nombre = adm.getNombres() + " " + adm.getApellidos();

  String sid = request.getParameter("id");
  PeriodoDao dao = DaoFactory.getPeriodoDao(Util.opc);
  PeriodoAcademico periodo = dao.find(Integer.parseInt(sid));
%>
<head><meta charset="UTF-8"><title>Editar Periodo - <%=nombre%></title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <h3>Actualizar Periodo</h3>
  <form action="pController" method="get">
    <input type="hidden" name="txtIdPeriodo" value="<%=periodo.getIdPeriodo()%>" />
    <div class="mb-2">
      <label>Nombre</label>
      <input class="form-control" type="text" name="txtNombre" required value="<%=periodo.getNombrePeriodo()%>">
    </div>
    <div class="mb-2">
      <label>Fecha Inicio</label>
      <input class="form-control" type="date" name="txtFechaInicio"
             value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(periodo.getFechaInicio()) %>" required>
    </div>
    <div class="mb-2">
      <label>Fecha Fin</label>
      <input class="form-control" type="date" name="txtFechaFin"
             value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(periodo.getFechaFin()) %>" required>
    </div>
    <div class="mb-2">
      <label>Estado</label>
      <select class="form-control" name="txtEstado">
        <option value="abierto" <%= "abierto".equals(periodo.getEstado()) ? "selected" : "" %>>abierto</option>
        <option value="cerrado" <%= "cerrado".equals(periodo.getEstado()) ? "selected" : "" %>>cerrado</option>
        <option value="inactivo" <%= "inactivo".equals(periodo.getEstado()) ? "selected" : "" %>>inactivo</option>
      </select>
    </div>

    <input type="hidden" name="accion" value="actualizar" />
    <div class="d-flex gap-2">
      <button class="btn btn-success" type="submit">Actualizar</button>
      <a class="btn btn-secondary" href="periodoMan.jsp">Regresar</a>
    </div>
  </form>
</div>
</body>
</html>
