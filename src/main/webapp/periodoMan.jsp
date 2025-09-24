<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
<%@ page import="com.tecsup.lab05.util.Util" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if (misesion.getAttribute("eladministrador") == null) {
    response.sendRedirect("error.jsp");
    return;
  }
  com.tecsup.lab05.model.entities.Administrador adm = (Administrador) session.getAttribute("eladministrador");
  String nombre = adm.getNombres() + " " + adm.getApellidos();

  PeriodoDao dao = DaoFactory.getPeriodoDao(Util.opc);
  java.util.List<PeriodoAcademico> list = dao.findAll();
%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Periodos - <%=nombre%></title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">

  <link rel="stylesheet" type="text/css" href="css/periodoMan.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container stagger-animation" style="margin-top:70px;">
  <!-- HEADER -->
  <div class="page-header">
    <h1><i class="fas fa-calendar-alt"></i> Periodos Académicos</h1>
    <p class="subtitle">Gestión y Administración de Períodos Educativos</p>
    <div class="admin-badge">
      <i class="fas fa-user-shield"></i> Administrador: <%= nombre %>
    </div>
  </div>

  <!-- STATISTICS SECTION -->
  <div class="stats-section">
    <%
      int totalPeriodos = (list != null) ? list.size() : 0;
      int periodosActivos = 0;
      int periodosInactivos = 0;

      if (list != null) {
        for (PeriodoAcademico p : list) {
          if ("activo".equals(p.getEstado())) {
            periodosActivos++;
          } else {
            periodosInactivos++;
          }
        }
      }
    %>

    <div class="stat-card">
      <i class="fas fa-calendar-check stat-icon"></i>
      <div class="stat-number"><%= totalPeriodos %></div>
      <div class="stat-label">Total Periodos</div>
    </div>

    <div class="stat-card">
      <i class="fas fa-play-circle stat-icon" style="color: var(--success);"></i>
      <div class="stat-number" style="background: linear-gradient(135deg, var(--success), #20c997); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;"><%= periodosActivos %></div>
      <div class="stat-label">Activos</div>
    </div>

    <div class="stat-card">
      <i class="fas fa-pause-circle stat-icon" style="color: var(--medium-gray);"></i>
      <div class="stat-number" style="background: linear-gradient(135deg, var(--medium-gray), #495057); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;"><%= periodosInactivos %></div>
      <div class="stat-label">Inactivos</div>
    </div>
  </div>

  <!-- ACTION BUTTONS -->
  <div class="action-section">
    <div class="action-group">
      <a class="btn btn-success" href="periodoInsertar.jsp">
        <i class="fas fa-plus-circle"></i> Nuevo Periodo
      </a>
    </div>
    <div class="action-group">
      <a class="btn btn-secondary" href="principal.jsp">
        <i class="fas fa-arrow-left"></i> Volver al Panel
      </a>
    </div>
  </div>

  <!-- TABLE SECTION -->
  <div class="modern-card">
    <div class="table-section">
      <div class="table-header">
        <div class="table-title">
          <i class="fas fa-table"></i>
          <h3>Lista de Periodos Académicos</h3>
        </div>
        <div class="periods-count">
          <%= totalPeriodos %> periodo<%= totalPeriodos != 1 ? "s" : "" %> registrado<%= totalPeriodos != 1 ? "s" : "" %>
        </div>
      </div>

      <% if (list == null || list.isEmpty()) { %>
      <div class="empty-state">
        <i class="fas fa-calendar-times"></i>
        <h3>No hay periodos académicos</h3>
        <p>Aún no se han registrado periodos académicos en el sistema.</p>
        <a class="btn btn-success" href="periodoInsertar.jsp">
          <i class="fas fa-plus"></i> Crear Primer Periodo
        </a>
      </div>
      <% } else { %>
      <div class="table-responsive">
        <table class="table">
          <thead>
          <tr>
            <th><i class="fas fa-tag"></i> Nombre del Periodo</th>
            <th><i class="fas fa-play"></i> Fecha de Inicio</th>
            <th><i class="fas fa-stop"></i> Fecha de Fin</th>
            <th><i class="fas fa-flag"></i> Estado</th>
            <th><i class="fas fa-cogs"></i> Acciones</th>
          </tr>
          </thead>
          <tbody>
          <% for (PeriodoAcademico p : list) { %>
          <tr>
            <td>
              <div class="period-name">
                <%= p.getNombrePeriodo() %>
              </div>
            </td>
            <td>
              <div class="date-info">
                <div class="date-value"><%= p.getFechaInicio() %></div>
                <div class="date-label">Inicio</div>
              </div>
            </td>
            <td>
              <div class="date-info">
                <div class="date-value"><%= p.getFechaFin() %></div>
                <div class="date-label">Finalización</div>
              </div>
            </td>
            <td>
                                <span class="status-badge status-<%= p.getEstado() %>">
                                    <% if ("activo".equals(p.getEstado())) { %>
                                        <i class="fas fa-circle" style="font-size: 0.6rem;"></i>
                                    <% } else if ("inactivo".equals(p.getEstado())) { %>
                                        <i class="fas fa-pause" style="font-size: 0.6rem;"></i>
                                    <% } else { %>
                                        <i class="fas fa-stop" style="font-size: 0.6rem;"></i>
                                    <% } %>
                                    <%= p.getEstado() %>
                                </span>
            </td>
            <td>
              <div class="action-buttons">
                <a class="btn btn-warning btn-sm"
                   href="periodoActualizar.jsp?id=<%= p.getIdPeriodo() %>"
                   title="Editar información del periodo">
                  <i class="fas fa-edit"></i> Editar
                </a>
                <a class="btn btn-danger btn-sm"
                   href="periodoEliminar.jsp?id=<%= p.getIdPeriodo() %>"
                   onclick="return confirm('¿Está seguro de eliminar el periodo \"<%= p.getNombrePeriodo() %>\"? Esta acción no se puede deshacer.');"
                title="Eliminar periodo">
                <i class="fas fa-trash-alt"></i> Eliminar
                </a>
              </div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>