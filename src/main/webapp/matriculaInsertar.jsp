<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.entities.Alumno" %>
<%@ page import="com.tecsup.lab05.model.entities.Curso" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.AlumnoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.CursoDao" %>
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
  com.tecsup.lab05.model.entities.Administrador adm = (Administrador) misesion.getAttribute("eladministrador");
  String nombreAdmin = adm.getNombres() + " " + adm.getApellidos();

  PeriodoDao pDao = DaoFactory.getPeriodoDao(Util.opc);
  java.util.List<PeriodoAcademico> periodos = pDao.findAll();

  AlumnoDao aDao = DaoFactory.getAlumnoDao(Util.opc);
  java.util.List<Alumno> alumnos = aDao.findAll();

  CursoDao cDao = DaoFactory.getCursoDao(Util.opc);
  java.util.List<Curso> cursos = cDao.findAll();
%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nueva Matrícula - <%=nombreAdmin%></title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/matriculaInsertar.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container main-container">
  <div class="card form-card fade-in">
    <div class="card-header-custom">
      <h3>
        <div class="icon">
          <i class="fas fa-user-graduate"></i>
        </div>
        Crear Matrícula
      </h3>
    </div>

    <div class="form-body">
      <div class="info-badge">
        <i class="fas fa-info-circle"></i>
        Complete todos los campos obligatorios para crear una nueva matrícula
      </div>

      <form action="matriculaController" method="get">
        <div class="mb-2">
          <label>
            <i class="fas fa-user"></i>
            Alumno
          </label>
          <select name="chrAluCodigo" class="form-control" required>
            <option value="">--Seleccionar--</option>
            <% for (Alumno a : alumnos) { %>
            <option value="<%=a.getCodigo()%>"><%=a.getNombres()%> <%=a.getApellidos()%> (<%=a.getCodigo()%>)</option>
            <% } %>
          </select>
        </div>

        <div class="mb-2">
          <label>
            <i class="fas fa-calendar-alt"></i>
            Periodo
          </label>
          <select name="idPeriodo" class="form-control" required>
            <option value="">--Seleccionar--</option>
            <% for (PeriodoAcademico p : periodos) { %>
            <option value="<%=p.getIdPeriodo()%>"><%=p.getNombrePeriodo()%></option>
            <% } %>
          </select>
        </div>

        <div class="mb-2">
          <label>
            <i class="fas fa-book"></i>
            Cursos (selecciona al menos 1)
          </label>
          <div class="courses-container">
            <% for (Curso c : cursos) { %>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" name="cursos" value="<%=c.getCodigo()%>" id="cur_<%=c.getCodigo()%>">
              <label class="form-check-label" for="cur_<%=c.getCodigo()%>">
                <div>
                  <strong><%=c.getNombre()%></strong>
                  <br>
                  <span class="course-code"><%=c.getCodigo()%></span>
                  <span class="course-credits"><%=c.getCreditos()%> cr</span>
                </div>
              </label>
            </div>
            <% } %>
          </div>
        </div>

        <input type="hidden" name="accion" value="create" />
        <div class="d-flex gap-2">
          <button class="btn btn-success" type="submit">
            <i class="fas fa-save"></i>
            Matricular
          </button>
          <a class="btn btn-secondary" href="matriculaMan.jsp">
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