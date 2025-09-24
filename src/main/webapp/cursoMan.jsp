<%--
  Created by IntelliJ IDEA.
  User: RNK
  Date: 16/09/2025
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.services.CursoService" %>
<%@ page import="com.tecsup.lab05.services.Impl.CursoServiceImpl" %>
<%@ page import="com.tecsup.lab05.model.entities.Curso" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
    HttpSession misesion = request.getSession();
    if(misesion.getAttribute("eladministrador")==null){
        response.sendRedirect("error.jsp");
    }else{
        Administrador adm = (Administrador)misesion.getAttribute("eladministrador");
        String nombre = adm.getNombres() + " " + adm.getApellidos();
        CursoService servicio = new CursoServiceImpl();
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
    <title>Mantenimiento de Cursos - <%=nombre %></title>
    <link rel="stylesheet" type="text/css" href="css/cursoMan.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container main-container">
    <!-- Header de página -->
    <div class="page-header fade-in">
        <h1>
            <div class="header-icon">
                <i class="fa fa-book"></i>
            </div>
            Mantenimiento de Cursos
        </h1>
    </div>

    <!-- Barra de acciones -->
    <div class="action-bar fade-in fade-in-delay-1">
        <div>
            <a href="cursoInsertar.jsp" class="btn-new-course">
                <i class="fa fa-plus"></i>
                Nuevo Curso
            </a>
        </div>
        <div class="course-count">
            <i class="fa fa-list"></i>
            Total de cursos: <%=servicio.listar().size()%>
        </div>
    </div>

    <!-- Tabla de cursos -->
    <div class="table-container fade-in fade-in-delay-2">
        <% if (servicio.listar().isEmpty()) { %>
        <div class="empty-state">
            <i class="fa fa-book-open"></i>
            <h4>No hay cursos registrados</h4>
            <p>Comience agregando un nuevo curso al sistema</p>
        </div>
        <% } else { %>
        <table class="table table-modern">
            <thead>
            <tr>
                <th><i class="fa fa-code me-2"></i>Código</th>
                <th><i class="fa fa-tag me-2"></i>Nombre</th>
                <th><i class="fa fa-star me-2"></i>Créditos</th>
                <th><i class="fa fa-cogs me-2"></i>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Curso curso : servicio.listar()) { %>
            <tr>
                <td>
                    <span class="course-code"><%=curso.getCodigo()%></span>
                </td>
                <td>
                    <div class="course-name"><%=curso.getNombre()%></div>
                </td>
                <td>
                    <span class="course-credits"><%=curso.getCreditos()%> cr</span>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="cursoActualizar.jsp?id=<%=curso.getCodigo()%>" class="btn-action btn-edit">
                            <i class="fa fa-edit"></i>
                            Editar
                        </a>
                        <a href="cursoEliminar.jsp?id=<%=curso.getCodigo()%>" class="btn-action btn-delete">
                            <i class="fa fa-trash"></i>
                            Eliminar
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

</body>
<% } %>
</html>






