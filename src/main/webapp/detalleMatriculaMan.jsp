<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.daos.DetalleMatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.MatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.CursoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.Impl.DaoFactory" %>
<%@ page import="com.tecsup.lab05.model.entities.DetalleMatricula" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.model.entities.Curso" %>
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
  com.tecsup.lab05.model.entities.Administrador adm = (Administrador) misesion.getAttribute("eladministrador");

  String sid = request.getParameter("idMatricula");
  int idMat = (sid != null && !sid.isEmpty()) ? Integer.parseInt(sid) : 0;

  MatriculaDao mDao = DaoFactory.getMatriculaDao(Util.opc);
  Matricula mat = (idMat>0) ? mDao.find(idMat) : null;

  DetalleMatriculaDao detDao = DaoFactory.getDetalleMatriculaDao(Util.opc);
  java.util.List<DetalleMatricula> detalles = (idMat>0) ? detDao.findByMatricula(idMat) : new java.util.ArrayList<>();

  CursoDao cDao = DaoFactory.getCursoDao(Util.opc);
%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Detalle Matrícula - Sistema Académico</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">

  <link rel="stylesheet" type="text/css" href="css/detalleMatriculaMan.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container stagger-animation" style="margin-top:70px;">
  <!-- HEADER -->
  <div class="page-header">
    <h1><i class="fas fa-file-alt"></i> Detalle de Matrícula</h1>
    <p class="subtitle">Información Detallada de Cursos Matriculados</p>
    <div class="matricula-id">
      <i class="fas fa-hashtag"></i> Matrícula ID: <%= idMat %>
    </div>
  </div>

  <!-- NAVIGATION -->
  <div class="navigation-section">
    <div>
      <a class="btn btn-secondary" href="matriculaMan.jsp">
        <i class="fas fa-arrow-left"></i> Volver a Matrículas
      </a>
    </div>
  </div>

  <% if (mat == null) { %>
  <!-- NO MATRICULA SELECTED -->
  <div class="modern-card">
    <div class="custom-alert">
      <i class="fas fa-exclamation-triangle"></i>
      <h4>Matrícula no encontrada</h4>
      <p>No se ha seleccionado una matrícula válida o la matrícula no existe en el sistema.</p>
    </div>
  </div>
  <% } else { %>

  <!-- STUDENT INFO SECTION -->
  <div class="modern-card">
    <div class="student-info">
      <div class="d-flex align-items-center mb-3">
        <i class="fas fa-user-graduate fa-2x text-primary mr-3"></i>
        <h4 class="mb-0" style="color: var(--primary-dark);">Información de la Matrícula</h4>
      </div>

      <div class="info-grid">
        <div class="info-item">
          <div class="info-label">
            <i class="fas fa-user"></i>
            Código de Alumno
          </div>
          <div class="info-value"><%= mat.getChrAluCodigo() %></div>
        </div>

        <div class="info-item">
          <div class="info-label">
            <i class="fas fa-calendar-alt"></i>
            Periodo Académico
          </div>
          <div class="info-value"><%= mat.getIdPeriodo() %></div>
        </div>

        <div class="info-item">
          <div class="info-label">
            <i class="fas fa-clock"></i>
            Fecha de Matrícula
          </div>
          <div class="info-value"><%= mat.getFechaMatricula() %></div>
        </div>

        <div class="info-item">
          <div class="info-label">
            <i class="fas fa-flag"></i>
            Estado
          </div>
          <div class="info-value">
                        <span class="status-badge status-<%= mat.getEstado() %>">
                            <i class="fas fa-circle" style="font-size: 0.6rem;"></i>
                            <%= mat.getEstado() %>
                        </span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- COURSES TABLE -->
  <div class="modern-card">
    <div class="table-section">
      <div class="table-header">
        <i class="fas fa-book"></i>
        <h4>Cursos Matriculados</h4>
        <div class="courses-count">
          <%= detalles.size() %> curso<%= detalles.size() != 1 ? "s" : "" %>
        </div>
      </div>

      <% if (detalles.isEmpty()) { %>
      <div class="empty-state">
        <i class="fas fa-book-open"></i>
        <h3>No hay cursos registrados</h3>
        <p>Esta matrícula no tiene cursos asociados.</p>
      </div>
      <% } else { %>
      <div class="table-responsive">
        <table class="table">
          <thead>
          <tr>
            <th><i class="fas fa-hashtag"></i> ID Detalle</th>
            <th><i class="fas fa-book"></i> Información del Curso</th>
            <th><i class="fas fa-flag"></i> Estado</th>
            <th><i class="fas fa-cogs"></i> Acciones</th>
          </tr>
          </thead>
          <tbody>
          <% for (DetalleMatricula d : detalles) {
            // obtener nombre del curso si es posible
            Curso c = cDao.find(d.getChrCurCodigo());
          %>
          <tr>
            <td><strong>#<%= d.getIdDetalle() %></strong></td>
            <td>
              <div class="course-info">
                <div class="course-name">
                  <%= (c != null ? c.getNombre() : "Curso no encontrado") %>
                </div>
                <div class="course-code">
                  Código: <%= d.getChrCurCodigo() %>
                </div>
              </div>
            </td>
            <td>
                                <span class="status-badge status-<%= d.getEstado() %>">
                                    <i class="fas fa-circle" style="font-size: 0.6rem;"></i>
                                    <%= d.getEstado() %>
                                </span>
            </td>
            <td>
              <% if (!"retirado".equals(d.getEstado()) && !"anulado".equals(d.getEstado())) { %>
              <a class="btn btn-danger btn-sm"
                 href="detalleMatriculaController?accion=retirar&idDetalle=<%=d.getIdDetalle()%>&idMatricula=<%=idMat%>"
                 onclick="return confirm('¿Está seguro de retirar este curso de la matrícula?');"
                 title="Retirar curso de la matrícula">
                <i class="fas fa-user-times"></i> Retirar Curso
              </a>
              <% } else { %>
              <span class="text-muted">
                                    <i class="fas fa-ban"></i> No disponible
                                </span>
              <% } %>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>