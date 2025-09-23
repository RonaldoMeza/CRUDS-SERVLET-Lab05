package com.tecsup.lab05.model.daos;

import com.tecsup.lab05.model.entities.Matricula;

import java.util.List;

public interface MatriculaDao extends EntidadDao<Matricula, Integer> {
    List<Matricula> findByAlumno(String chrAluCodigo);
    // otros filtros si los necesitas
}
