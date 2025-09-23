<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.daos.DetalleMatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
<%@ page import="com.tecsup.lab05.model.entities.DetalleMatricula" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if(misesion.getAttribute("eladministrador")==null){
    response.sendRedirect("error.jsp");
  }
  String sidMat = request.getParameter("idMatricula");
  int idMat = sidMat != null ? Integer.parseInt(sidMat) : 0;
  DetalleMatriculaDao dao = com.tecsup.lab05.model.daos.Impl.DaoFactory.getDetalleMatriculaDao(com.tecsup.lab05.util.Util.opc);
  java.util.List<DetalleMatricula> detalles = dao.findByMatricula(idMat);
%>
<head><meta charset="UTF-8"><title>Detalle Matrícula</title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
  <h1>Detalle Matrícula: <%=idMat%></h1>
  <table class="table table-dark table-hover">
    <tr>
      <th>ID</th><th>CURSO</th><th>ESTADO</th><th>ACCIONES</th>
    </tr>
    <% for (DetalleMatricula d : detalles) { %>
    <tr>
      <td><%=d.getIdDetalle()%></td>
      <td><%=d.getChrCurCodigo()%></td>
      <td><%=d.getEstado()%></td>
      <td>
        <a class="btn btn-danger" href="detalleMatriculaController?accion=retirar&idDetalle=<%=d.getIdDetalle()%>">Retirar</a>
      </td>
    </tr>
    <% } %>
  </table>
</div>
</body>
</html>
