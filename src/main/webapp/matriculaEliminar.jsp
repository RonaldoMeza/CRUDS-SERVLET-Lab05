<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.model.daos.MatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
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
    MatriculaDao dao = DaoFactory.getMatriculaDao(com.tecsup.lab05.util.Util.opc);
    Matricula m = dao.find(Integer.parseInt(sid));
%>
<head>
  <meta charset="UTF-8">
  <title>Eliminar Matrícula - <%=nombre%></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-6 mx-auto">
    <div class="card text-center">
      <div class="card-header"><h3>ELIMINAR MATRÍCULA</h3></div>
      <div class="card-body">
        <form action="mController">
          <div class="input-group mt-2">
            <label class="input-group-text">ID Matrícula</label>
            <input class="form-control" type="text" name="idMatricula" readonly value="<%=m.getIdMatricula()%>"/>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Alumno</label>
            <input class="form-control" type="text" readonly value="<%=m.getChrAluCodigo()%>"/>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Periodo</label>
            <input class="form-control" type="text" readonly value="<%=m.getIdPeriodo()%>"/>
          </div>

          <div class="form-group mt-4 d-grid gap-2">
            <!-- Usamos accion 'retirar' para mantener la lógica de borrar lógico -->
            <input type="hidden" name="accion" value="retirar"/>
            <input class="btn btn-danger" type="submit" value="Retirar Matrícula"/>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
<% } %>
</html>
