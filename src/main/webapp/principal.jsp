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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="" crossorigin="anonymous" />
    <title>Inicio - Sistema Académico</title>
    <link rel="stylesheet" type="text/css" href="css/principal.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container main-container">
    <!-- Header de bienvenida -->
    <div class="welcome-header fade-in">
        <div class="welcome-content">
            <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between">
                <div>
                    <h4>Bienvenido, <%=nombre%></h4>
                    <div class="text-muted">Panel de administración — Sistema Académico</div>
                </div>

            </div>
        </div>
    </div>

    <!-- Tarjetas de navegación -->
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card nav-card fade-in fade-in-delay-1">
                <div class="card-body d-flex flex-column">
                    <div class="card-icon-wrapper icon-cursos">
                        <i class="fa fa-book fa-2x"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Cursos</h5>
                    <p class="card-text flex-grow-1">Crear, editar y eliminar cursos. Gestiona créditos y nombres de cada curso disponible en el sistema.</p>
                    <a href="cursoMan.jsp" class="btn btn-card btn-primary-custom mt-2">
                        <i class="fa fa-arrow-right me-2"></i>Ir a Cursos
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card nav-card fade-in fade-in-delay-2">
                <div class="card-body d-flex flex-column">
                    <div class="card-icon-wrapper icon-matriculas">
                        <i class="fa fa-user-graduate fa-2x"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Matrículas</h5>
                    <p class="card-text flex-grow-1">Registrar matrículas por periodo y gestionar bajas/retirados sin eliminar datos históricos.</p>
                    <a href="matriculaMan.jsp" class="btn btn-card btn-success-custom mt-2">
                        <i class="fa fa-arrow-right me-2"></i>Ir a Matrículas
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card nav-card fade-in fade-in-delay-3">
                <div class="card-body d-flex flex-column">
                    <div class="card-icon-wrapper icon-periodos">
                        <i class="fa fa-calendar-alt fa-2x"></i>
                    </div>
                    <h5 class="card-title">Mantenimiento de Períodos</h5>
                    <p class="card-text flex-grow-1">Crear y gestionar periodos académicos con sus respectivas fechas de inicio/fin y estado.</p>
                    <a href="periodoMan.jsp" class="btn btn-card btn-warning-custom mt-2">
                        <i class="fa fa-arrow-right me-2"></i>Ir a Períodos
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sección de ayuda rápida -->
    <div class="help-section fade-in fade-in-delay-4">
        <div class="d-flex align-items-start">
            <i class="fa fa-lightbulb help-icon"></i>
            <p class="help-text">
                <strong>Consejo:</strong> Para ver el detalle de una matrícula, primero abra
                <strong>Matrículas</strong> y use el botón <em>Detalle</em> en la fila correspondiente.
                Esto le permitirá gestionar los cursos inscritos y el estado de cada estudiante.
            </p>
        </div>
    </div>
</div>

</body>
<% } %>
</html>