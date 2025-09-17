<%--
  Created by IntelliJ IDEA.
  User: RNK
  Date: 16/09/2025
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
    HttpSession misesion = request.getSession();
    if(misesion.getAttribute("eladministrador")==null){
        response.sendRedirect("error.jsp");
    }else{
        Administrador adm = (Administrador)misesion.getAttribute("eladministrador");
        String nombre = adm.getNombres() + " " + adm.getApellidos();
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Intranet</title>
</head>
<body>
<jsp:include page="master.jsp" />

<h2><a href="cursoMan.jsp">Mantenimiento de cursos</a> </h2>

</body>
<% } %>
</html>






