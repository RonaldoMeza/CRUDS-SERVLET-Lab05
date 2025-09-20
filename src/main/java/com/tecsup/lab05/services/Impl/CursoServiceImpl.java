package com.tecsup.lab05.services.Impl;

import com.tecsup.lab05.model.daos.CursoDao;
import com.tecsup.lab05.model.daos.Impl.DaoFactory;
import com.tecsup.lab05.model.entities.Curso;
import com.tecsup.lab05.services.CursoService;
import com.tecsup.lab05.util.Util;

import java.util.List;

public class CursoServiceImpl implements CursoService {

    private CursoDao dao;

    public CursoServiceImpl() {
        dao = DaoFactory.getCursoDao(Util.opc);
    }

    @Override
    public void grabar(Curso curso) {
        dao.create(curso);
    }

    @Override
    public Curso buscar(String id) {
        return dao.find(id);
    }

    @Override
    public List<Curso> listar() {
        return dao.findAll();
    }

    @Override
    public void actualizar(Curso curso) {
        dao.update(curso);
    }

    @Override
    public void eliminar(String id) {
        dao.delete(id);
    }

    @Override
    public List<Curso> filterByCreditos(int min, int max) {
        return  dao.findByRangeCreditos(min, max);
    }
}
