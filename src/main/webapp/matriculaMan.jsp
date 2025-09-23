<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.services.Impl.MatriculaServiceImpl" %>
<%@ page import="com.tecsup.lab05.services.MatriculaService" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
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
        com.tecsup.lab05.model.daos.MatriculaDao dao = com.tecsup.lab05.model.daos.Impl.DaoFactory.getMatriculaDao(com.tecsup.lab05.util.Util.opc);
        java.util.List<Matricula> lista = dao.findAll();
%>
<head><meta charset="UTF-8"><title>Matriculas - <%=nombre%></title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container" style="margin-top:70px;">
    <h1>Matriculas</h1>
    <div style="padding:10px;">
        <a class="btn btn-danger" href="matriculaInsertar.jsp">Nueva Matrícula</a>
    </div>

    <table class="table table-dark table-hover">
        <tr align="center">
            <th>ID</th>
            <th>ALUMNO</th>
            <th>PERIODO</th>
            <th>FECHA</th>
            <th>ESTADO</th>
            <th>ACCIONES</th>
        </tr>
        <% for (Matricula m : lista) { %>
        <tr>
            <td><%=m.getIdMatricula()%></td>
            <td><%=m.getChrAluCodigo()%></td>
            <td><%=m.getIdPeriodo()%></td>
            <td><%=m.getFechaMatricula()%></td>
            <td><%=m.getEstado()%></td>
            <td>
                <a class="btn btn-warning" href="detalleMatriculaMan.jsp?idMatricula=<%=m.getIdMatricula()%>">Detalle</a>
                <a class="btn btn-danger" href="matriculaController?accion=retirar&idMatricula=<%=m.getIdMatricula()%>">Retirar</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
<% } %>
</html>
