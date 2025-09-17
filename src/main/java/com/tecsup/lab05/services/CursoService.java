package com.tecsup.lab05.services;

import com.tecsup.lab05.model.entities.Curso;

import java.util.List;

public interface CursoService {
    public void grabar(Curso curso);
    public Curso buscar(String id);
    public List<Curso> listar();
    public void actualizar(Curso curso);
    public void eliminar(String id);

    public List<Curso> filterByCreditos(int min, int max);
}
