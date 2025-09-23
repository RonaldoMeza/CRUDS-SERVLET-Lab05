package com.tecsup.lab05.model.daos;

import com.tecsup.lab05.model.entities.DetalleMatricula;

import java.util.List;

public interface DetalleMatriculaDao extends EntidadDao<DetalleMatricula, Integer> {
    List<DetalleMatricula> findByMatricula(int idMatricula);
}
