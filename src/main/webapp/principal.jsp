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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Opcional: iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="" crossorigin="anonymous" />
    <title>Inicio - Sistema Académico</title>
</head>
<body>
<jsp:include page="master.jsp" />

<div class="container" style="margin-top: 40px;">
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between p-3 bg-light rounded shadow-sm">
                <div>
                    <h4 class="mb-0">Bienvenido, <strong><%= nombre %></strong></h4>
                    <small class="text-muted">Panel de administración — Sistema Académico</small>
                </div>
                <div>
                    <!-- Botones rápidos -->
                    <a href="miPerfil.jsp" class="btn btn-outline-secondary btn-sm me-2"><i class="fa fa-user"></i> Mi perfil</a>
                    <a href="logout.jsp" class="btn btn-outline-danger btn-sm"><i class="fa fa-sign-out-alt"></i> Cerrar sesión</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Tarjetas de navegación -->
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <div class="mb-3">
                        <i class="fa fa-book fa-2x text-primary"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Cursos</h5>
                    <p class="card-text flex-grow-1">Crear, editar y eliminar cursos. Gestiona créditos y nombres de cada curso.</p>
                    <a href="cursoMan.jsp" class="btn btn-primary mt-2">Ir a Cursos</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <div class="mb-3">
                        <i class="fa fa-user-graduate fa-2x text-success"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Matrículas</h5>
                    <p class="card-text flex-grow-1">Registrar matrículas por periodo y gestionar bajas/retirados sin eliminar datos.</p>
                    <a href="matriculaMan.jsp" class="btn btn-success mt-2">Ir a Matrículas</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <div class="mb-3">
                        <i class="fa fa-calendar-alt fa-2x text-warning"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Períodos</h5>
                    <p class="card-text flex-grow-1">Crear y gestionar periodos académicos (fechas de inicio/fin, estado).</p>
                    <a href="periodoMan.jsp" class="btn btn-warning mt-2">Ir a Períodos</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sección de ayuda rápida -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="alert alert-info small">
                Consejo: para ver el detalle de una matrícula, primero abra <strong>Matrículas</strong> y use el botón <em>Detalle</em> en la fila correspondiente.
            </div>
        </div>
    </div>
</div>

</body>
<% } %>
</html>







