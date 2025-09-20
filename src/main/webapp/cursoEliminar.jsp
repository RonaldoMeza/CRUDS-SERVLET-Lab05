<%--
  Created by IntelliJ IDEA.
  User: RNK
  Date: 16/09/2025
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@ page import="com.tecsup.lab05.model.entities.Curso" %>
<%@ page import="com.tecsup.lab05.services.CursoService" %>
<%@ page import="com.tecsup.lab05.services.Impl.CursoServiceImpl" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%
    HttpSession misesion = request.getSession();
    if(misesion.getAttribute("eladministrador")==null){
        response.sendRedirect("error.jsp");
    }else{
        Administrador adm = (Administrador)misesion.getAttribute("eladministrador");
        String nombre = adm.getNombres() + " " + adm.getApellidos();
        String sid = request.getParameter("id");
        CursoService servicio = new CursoServiceImpl();
        Curso curso = servicio.buscar(sid);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Curso Eliminar - <%=nombre %></title>
</head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px ;">
    <div class="row">
        <div class="col-md-4 mx-auto">
            <div class="card text-center">
                <div class="card-header">
                    <h3 class="text-uppercase">ELIMINAR CURSO</h3>
                </div>
                <div class="card-body">
                    <form action="cController">
                        <div class="input-group mt-2">
                            <label class="input-group-text">Codigo</label>
                            <input class="form-control" type="text" name="txtCodigo"
                                   value="<%=curso.getCodigo() %>" readonly>
                        </div>
                        <div class="input-group mt-2">
                            <label class="input-group-text">Nombre</label>
                            <input class="form-control" type="text" name="txtNombre"
                                   value="<%=curso.getNombre() %>" readonly>
                        </div>
                        <div class="input-group mt-2">
                            <label class="input-group-text">Creditos</label>
                            <input class="form-control" type="text" name="txtCreditos"
                                   value="<%=curso.getCreditos() %>" readonly>
                        </div>
                        <div class="form-group mt-4 d-grid gap-2">
                            <input name="accion" type="hidden" value="eliminar"/>
                            <input class="btn btn-danger" type="submit" value="Eliminar"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
    }
%>