<%@ page import="com.tecsup.lab05.model.entities.Administrador" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%
  HttpSession misesion = request.getSession();
  if(misesion.getAttribute("eladministrador")==null){
    response.sendRedirect("error.jsp");
  }
  com.tecsup.lab05.model.entities.Administrador adm = (Administrador)misesion.getAttribute("eladministrador");
%>
<head><meta charset="UTF-8"><title>Nuevo Periodo</title></head>
<body>
<jsp:include page="master.jsp" />
<div class="container p-4" style="margin-top:70px;">
  <div class="col-md-6 mx-auto">
    <div class="card text-center">
      <div class="card-header"><h3>CREAR PERIODO</h3></div>
      <div class="card-body">
        <form action="pController">
          <div class="input-group mt-2">
            <label class="input-group-text">Nombre</label>
            <input class="form-control" type="text" name="txtNombre" required placeholder="2025-I">
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Inicio</label>
            <input class="form-control" type="date" name="txtFechaInicio" required>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Fecha Fin</label>
            <input class="form-control" type="date" name="txtFechaFin" required>
          </div>
          <div class="input-group mt-2">
            <label class="input-group-text">Estado</label>
            <select name="txtEstado" class="form-control">
              <option value="abierto">abierto</option>
              <option value="cerrado">cerrado</option>
              <option value="inactivo">inactivo</option>
            </select>
          </div>
          <div class="form-group mt-4 d-grid gap-2">
            <input type="hidden" name="accion" value="insertar"/>
            <input class="btn btn-success" type="submit" value="Insertar"/>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
