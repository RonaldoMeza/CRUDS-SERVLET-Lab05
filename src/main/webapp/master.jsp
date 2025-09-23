<%--
  Created by IntelliJ IDEA.
  User: RNK
  Date: 16/09/2025
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sistema Académico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar bg-primary navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand link-warning fs-3" href="#">Sistema Académico</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll"
                aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav mx-auto my-2 my-lg-0 navbar-nav-scroll " style="--bs-scroll-height: 100px;">
                <li class="nav-item">
                    <a class="nav-link link-light" aria-current="page" href="principal.jsp">Inicio</a>
                </li>

                <!-- Nuevo módulo de Matrícula -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle link-light" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Gestión Matrícula
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="matriculaMan.jsp">Matrículas</a></li>
                        <li><a class="dropdown-item" href="periodoMan.jsp">Periodos Académicos</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link link-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Gestión Cursos
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="cursoMan.jsp">Cursos</a></li>
                        <li><a class="dropdown-item" href="#">Créditos</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle link-light" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Gestión Docente
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Docentes</a></li>
                        <li><a class="dropdown-item" href="#">Especialidad</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle link-light" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Gestión Alumnos
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Alumnos</a></li>
                        <li><a class="dropdown-item" href="#">Apoderado</a></li>
                    </ul>
                </li>
            </ul>

            <!-- Información del usuario logueado -->
            <div class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle link-light" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <%= session.getAttribute("nombreAdmin") != null ? session.getAttribute("nombreAdmin") : "Usuario" %>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="miPerfil.jsp">Mi Perfil</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </div>
        </div>
    </div>
</nav>

<!-- Espacio para evitar que el contenido quede detrás del navbar fixed -->
<div style="height: 80px;"></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


