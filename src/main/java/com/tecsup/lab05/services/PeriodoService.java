package com.tecsup.lab05.services;

import com.tecsup.lab05.model.entities.PeriodoAcademico;
import java.util.List;

public interface PeriodoService {
    void grabar(PeriodoAcademico p);
    PeriodoAcademico buscar(int id);
    List<PeriodoAcademico> listar();
    void actualizar(PeriodoAcademico p);
    void eliminar(int id);
}
