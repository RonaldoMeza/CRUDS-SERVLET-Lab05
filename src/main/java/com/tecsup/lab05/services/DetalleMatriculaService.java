package com.tecsup.lab05.services;

import com.tecsup.lab05.model.entities.DetalleMatricula;
import java.util.List;

public interface DetalleMatriculaService {
    void grabar(DetalleMatricula detalle);
    DetalleMatricula buscar(int id);
    List<DetalleMatricula> listar();
    void actualizar(DetalleMatricula detalle);
    void eliminar(int id);

    // método específico
    List<DetalleMatricula> listarPorMatricula(int idMatricula);
}
