package com.tecsup.lab05.services.Impl;

import com.tecsup.lab05.model.daos.PeriodoDao;
import com.tecsup.lab05.model.daos.Impl.DaoFactory;
import com.tecsup.lab05.model.entities.PeriodoAcademico;
import com.tecsup.lab05.services.PeriodoService;
import com.tecsup.lab05.util.Util;

import java.util.List;

public class PeriodoServiceImpl implements PeriodoService {
    private PeriodoDao dao;

    public PeriodoServiceImpl() {
        dao = DaoFactory.getPeriodoDao(Util.opc);
    }

    @Override
    public void grabar(PeriodoAcademico p) { dao.create(p); }

    @Override
    public PeriodoAcademico buscar(int id) { return dao.find(id); }

    @Override
    public List<PeriodoAcademico> listar() { return dao.findAll(); }

    @Override
    public void actualizar(PeriodoAcademico p) { dao.update(p); }

    @Override
    public void eliminar(int id) { dao.delete(id); }
}
