package com.tecsup.lab05.services;

import com.tecsup.lab05.model.entities.Matricula;

import java.util.List;

public interface MatriculaService {
    // crea matricula con detalles transaccionalmente; devuelve idMatricula
    int crearMatriculaConCursos(String chrAluCodigo, int idPeriodo, List<String> codigosCursos) throws Exception;

    // operaciones CRUD simples
    void actualizar(Matricula m) throws Exception;
    void eliminar(int id) throws Exception;
    List<Matricula> listar() throws Exception;
    Matricula buscar(int id) throws Exception;
}
