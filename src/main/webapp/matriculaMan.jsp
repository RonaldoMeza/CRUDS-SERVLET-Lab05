<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Matricula" %>
<%@ page import="com.tecsup.lab05.model.entities.PeriodoAcademico" %>
<%@ page import="com.tecsup.lab05.model.entities.Alumno" %>
<%@ page import="com.tecsup.lab05.model.daos.MatriculaDao" %>
<%@ page import="com.tecsup.lab05.model.daos.PeriodoDao" %>
<%@ page import="com.tecsup.lab05.model.daos.AlumnoDao" %>
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

    // cargar listas
    MatriculaDao matriculaDao = DaoFactory.getMatriculaDao(Util.opc);
    java.util.List<Matricula> lista = matriculaDao.findAll();

    PeriodoDao periodoDao = DaoFactory.getPeriodoDao(Util.opc);
    java.util.List<PeriodoAcademico> periodos = periodoDao.findAll();
    java.util.Map<Integer, String> mapPeriodos = new java.util.HashMap<>();
    for (PeriodoAcademico p : periodos) mapPeriodos.put(p.getIdPeriodo(), p.getNombrePeriodo());

    AlumnoDao alumnoDao = DaoFactory.getAlumnoDao(Util.opc);
    java.util.List<Alumno> alumnos = alumnoDao.findAll();
    java.util.Map<String, String> mapAlumnos = new java.util.HashMap<>();
    for (Alumno a : alumnos) mapAlumnos.put(a.getCodigo(), a.getNombres() + " " + a.getApellidos());

    // filtros (opcionales: recibidos por GET)
    String filtroPeriodo = request.getParameter("fPeriodo");
    String filtroEstado = request.getParameter("fEstado");
    String filtroAlumno = request.getParameter("fAlumno");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matriculas - <%=nombreAdmin%></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">

    <link rel="stylesheet" type="text/css" href="css/matriculaMan.css">

</head>
<body>
<jsp:include page="master.jsp" />

<div class="container stagger-animation" style="margin-top:70px;">
    <!-- HEADER -->
    <div class="page-header">
        <h1><i class="fas fa-graduation-cap"></i> Gestión de Matrículas</h1>
        <p class="subtitle">Sistema Académico - Panel de Administración</p>
    </div>

    <!-- FILTER SECTION -->
    <div class="modern-card">
        <div class="filter-section">
            <div class="filter-title">
                <i class="fas fa-filter"></i>
                Filtros de Búsqueda
            </div>
            <form class="row" method="get" action="matriculaMan.jsp">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="form-group">
                        <label>
                            <i class="fas fa-calendar-alt"></i>
                            Periodo Académico
                        </label>
                        <select name="fPeriodo" class="form-control">
                            <option value="">-- Seleccionar Periodo --</option>
                            <% for (PeriodoAcademico p : periodos) { %>
                            <option value="<%=p.getIdPeriodo()%>" <%= (String.valueOf(p.getIdPeriodo()).equals(filtroPeriodo) ? "selected" : "") %>>
                                <%=p.getNombrePeriodo()%>
                            </option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="form-group">
                        <label>
                            <i class="fas fa-flag"></i>
                            Estado de Matrícula
                        </label>
                        <select name="fEstado" class="form-control">
                            <option value="">-- Todos los Estados --</option>
                            <option value="activo" <%= "activo".equals(filtroEstado) ? "selected" : "" %>>Activo</option>
                            <option value="retirado" <%= "retirado".equals(filtroEstado) ? "selected" : "" %>>Retirado</option>
                            <option value="anulado" <%= "anulado".equals(filtroEstado) ? "selected" : "" %>>Anulado</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-4 col-md-8 mb-3">
                    <div class="form-group">
                        <label>
                            <i class="fas fa-user-graduate"></i>
                            Buscar Alumno
                        </label>
                        <input class="form-control"
                               type="text"
                               name="fAlumno"
                               value="<%= filtroAlumno != null ? filtroAlumno : "" %>"
                               placeholder="Ingrese nombre o código del estudiante...">
                    </div>
                </div>

                <div class="col-lg-2 col-md-4 mb-3">
                    <div class="form-group">
                        <label style="opacity: 0;">Acciones</label>
                        <div class="d-flex flex-column gap-2">
                            <button class="btn btn-primary" type="submit">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                            <a class="btn btn-secondary btn-sm" href="matriculaMan.jsp">
                                <i class="fas fa-eraser"></i> Limpiar
                            </a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- ACTION BUTTONS -->
    <div class="action-section">
        <div>
            <a class="btn btn-success" href="matriculaInsertar.jsp">
                <i class="fas fa-plus-circle"></i> Nueva Matrícula
            </a>
        </div>
        <div>
            <a class="btn btn-secondary" href="principal.jsp">
                <i class="fas fa-arrow-left"></i> Volver al Panel
            </a>
        </div>
    </div>

    <!-- TABLE SECTION -->
    <div class="modern-card">
        <div class="table-section">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-user-graduate"></i> Estudiante</th>
                        <th><i class="fas fa-calendar-alt"></i> Periodo</th>
                        <th><i class="fas fa-clock"></i> Fecha de Matrícula</th>
                        <th><i class="fas fa-flag"></i> Estado</th>
                        <th><i class="fas fa-cogs"></i> Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (lista == null || lista.isEmpty()) { %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-inbox"></i>
                                <h3>No hay matrículas registradas</h3>
                                <p>No se encontraron matrículas con los criterios especificados.</p>
                            </div>
                        </td>
                    </tr>
                    <% } else {
                        for (Matricula m : lista) {
                            // aplicar filtros simples en JSP (si se usará SP, sustituirlo)
                            boolean mostrar = true;
                            if (filtroPeriodo != null && !filtroPeriodo.isEmpty()) {
                                if (!String.valueOf(m.getIdPeriodo()).equals(filtroPeriodo)) mostrar = false;
                            }
                            if (filtroEstado != null && !filtroEstado.isEmpty()) {
                                if (!filtroEstado.equals(m.getEstado())) mostrar = false;
                            }
                            if (filtroAlumno != null && !filtroAlumno.isEmpty()) {
                                String nombreA = mapAlumnos.getOrDefault(m.getChrAluCodigo(), m.getChrAluCodigo());
                                if (!(nombreA.toLowerCase().contains(filtroAlumno.toLowerCase()) || m.getChrAluCodigo().toLowerCase().contains(filtroAlumno.toLowerCase())))
                                    mostrar = false;
                            }
                            if (!mostrar) continue;

                            String nombrePeriodo = mapPeriodos.getOrDefault(m.getIdPeriodo(), String.valueOf(m.getIdPeriodo()));
                            String nombreAlumno = mapAlumnos.getOrDefault(m.getChrAluCodigo(), m.getChrAluCodigo());
                    %>
                    <tr>
                        <td><strong>#<%=m.getIdMatricula()%></strong></td>
                        <td>
                            <div>
                                <strong><%=nombreAlumno%></strong><br>
                                <small class="text-muted">Código: <%=m.getChrAluCodigo()%></small>
                            </div>
                        </td>
                        <td><%=nombrePeriodo%></td>
                        <td><%=m.getFechaMatricula()%></td>
                        <td>
                                <span class="status-badge status-<%=m.getEstado()%>">
                                    <i class="fas fa-circle" style="font-size: 0.6rem; margin-right: 0.3rem;"></i>
                                    <%=m.getEstado()%>
                                </span>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <a class="btn btn-warning btn-sm"
                                   href="detalleMatriculaMan.jsp?idMatricula=<%=m.getIdMatricula()%>"
                                   title="Ver detalles de la matrícula">
                                    <i class="fas fa-eye"></i> Detalle
                                </a>
                                <a class="btn btn-primary btn-sm"
                                   href="matriculaActualizar.jsp?id=<%=m.getIdMatricula()%>"
                                   title="Editar información de la matrícula">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <a class="btn btn-danger btn-sm"
                                   href="matriculaController?accion=retirar&idMatricula=<%=m.getIdMatricula()%>"
                                   onclick="return confirm('¿Está seguro de retirar esta matrícula? Esta acción marcará el estado como retirado.');"
                                   title="Retirar matrícula">
                                    <i class="fas fa-user-times"></i> Retirar
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%     }
                    } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>