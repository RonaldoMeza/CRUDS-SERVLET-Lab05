<%--
  Created by IntelliJ IDEA.
  User: RNK
  Date: 16/09/2025
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Error de Acceso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card text-center">
                <div class="card-header bg-danger text-white">
                    <h3>Error de Acceso</h3>
                </div>
                <div class="card-body">
                    <div class="alert alert-warning">
                        <strong>No tiene permisos para acceder a esta página.</strong><br>
                        Debe iniciar sesión para continuar.
                    </div>
                    <a href="acceso.jsp" class="btn btn-primary">Regresar</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
