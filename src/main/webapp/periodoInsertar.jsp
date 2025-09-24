<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if (misesion.getAttribute("eladministrador") == null) {
    response.sendRedirect("error.jsp");
    return;
  }
  com.tecsup.lab05.model.entities.Administrador adm = (com.tecsup.lab05.model.entities.Administrador) session.getAttribute("eladministrador");
  String nombre = adm.getNombres() + " " + adm.getApellidos();
%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nuevo Periodo - <%=nombre%></title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/periodoInsertar.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container main-container">
  <div class="card form-card fade-in">
    <div class="card-header-custom">
      <h3>
        <div class="icon">
          <i class="fas fa-calendar-plus"></i>
        </div>
        Crear Periodo Académico
      </h3>
    </div>

    <div class="form-body">
      <div class="info-badge">
        <i class="fas fa-info-circle"></i>
        Complete la información del nuevo periodo académico. Las fechas deben ser válidas y coherentes.
      </div>

      <form action="pController" method="get">
        <div class="form-group">
          <label class="form-label">
            <i class="fas fa-tag"></i>
            Nombre del Periodo
          </label>
          <div class="input-group-custom">
            <i class="fas fa-graduation-cap input-icon"></i>
            <input class="form-control" type="text" name="txtNombre" required
                   placeholder="Ej: 2025-I, 2025-II, Verano 2025">
          </div>
          <div class="form-helper-text">
            Ingrese un nombre descriptivo para el periodo académico
          </div>
        </div>

        <div class="date-row">
          <div class="form-group">
            <label class="form-label">
              <i class="fas fa-calendar-day"></i>
              Fecha de Inicio
            </label>
            <input class="form-control" type="date" name="txtFechaInicio" required>
            <div class="form-helper-text">
              Fecha cuando inicia el periodo académico
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">
              <i class="fas fa-calendar-check"></i>
              Fecha de Fin
            </label>
            <input class="form-control" type="date" name="txtFechaFin" required>
            <div class="form-helper-text">
              Fecha cuando termina el periodo académico
            </div>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">
            <i class="fas fa-toggle-on"></i>
            Estado del Periodo
          </label>
          <select class="form-select status-select" name="txtEstado">
            <option value="abierto">Abierto <span class="status-badge status-abierto">●</span></option>
            <option value="cerrado">Cerrado <span class="status-badge status-cerrado">●</span></option>
            <option value="inactivo">Inactivo <span class="status-badge status-inactivo">●</span></option>
          </select>
          <div class="form-helper-text">
            • <strong>Abierto:</strong> Periodo disponible para matrículas<br>
            • <strong>Cerrado:</strong> Periodo finalizado, sin matrículas<br>
            • <strong>Inactivo:</strong> Periodo suspendido temporalmente
          </div>
        </div>

        <input type="hidden" name="accion" value="insertar" />

        <div class="button-group">
          <button class="btn btn-custom-primary" type="submit">
            <i class="fas fa-save"></i>
            Crear Periodo
          </button>
          <a class="btn btn-custom-secondary" href="periodoMan.jsp">
            <i class="fas fa-arrow-left"></i>
            Regresar
          </a>
        </div>
      </form>
    </div>
  </div>
</div>


</body>
</html>