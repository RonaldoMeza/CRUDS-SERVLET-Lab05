package com.tecsup.lab05.model.daos;

import com.tecsup.lab05.model.entities.Alumno;
import java.util.List;

public interface AlumnoDao extends EntidadDao<Alumno, String> {
    List<Alumno> findByApellido(String apellido);
}
