package com.tecsup.lab05.model.daos;

import com.tecsup.lab05.model.entities.Curso;

import java.awt.*;
import java.util.List;

public interface CursoDao extends EntidadDao<Curso, String>{
    // definir todos los métodos
        public List<Curso> findByRangeCreditos(int min, int max);
        public List<Curso> findByNombre(String nombre);
}
