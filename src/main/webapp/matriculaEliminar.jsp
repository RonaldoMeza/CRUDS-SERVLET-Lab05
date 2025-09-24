<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.model.daos.MatriculaDao" %>
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
  com.tecsup.lab05.model.entities.Administrador adm = (Administrador) misesion.getAttribute("eladministrador");
  String nombreAdmin = adm.getNombres() + " " + adm.getApellidos();

  String sid = request.getParameter("id");
  MatriculaDao mDao = DaoFactory.getMatriculaDao(Util.opc);
  Matricula m = mDao.find(Integer.parseInt(sid));
%>
<head><meta charset="UTF-8"><title>Retirar Matrícula - <%=nombreAdmin%></title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <h3>Retirar Matrícula</h3>
  <p>¿Está seguro de retirar la matrícula <strong><%= m.getIdMatricula() %></strong> del alumno <strong><%= m.getChrAluCodigo() %></strong>?</p>
  <form action="matriculaController" method="get">
    <input type="hidden" name="idMatricula" value="<%=m.getIdMatricula()%>" />
    <input type="hidden" name="accion" value="retirar" />
    <div class="d-flex gap-2">
      <button class="btn btn-danger" type="submit">Retirar</button>
      <a class="btn btn-secondary" href="matriculaMan.jsp">Regresar</a>
    </div>
  </form>
</div>
</body>
</html>
