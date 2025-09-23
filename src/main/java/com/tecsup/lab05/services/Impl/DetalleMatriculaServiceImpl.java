package com.tecsup.lab05.services.Impl;

import com.tecsup.lab05.model.daos.DetalleMatriculaDao;
import com.tecsup.lab05.model.daos.Impl.DaoFactory;
import com.tecsup.lab05.model.entities.DetalleMatricula;
import com.tecsup.lab05.services.DetalleMatriculaService;
import com.tecsup.lab05.util.Util;

import java.util.List;

public class DetalleMatriculaServiceImpl implements DetalleMatriculaService {

    private DetalleMatriculaDao dao;

    public DetalleMatriculaServiceImpl() {
        this.dao = DaoFactory.getDetalleMatriculaDao(Util.opc);
    }

    @Override
    public void grabar(DetalleMatricula detalle) {
        dao.create(detalle);
    }

    @Override
    public DetalleMatricula buscar(int id) {
        return dao.find(id);
    }

    @Override
    public List<DetalleMatricula> listar() {
        return dao.findAll();
    }

    @Override
    public void actualizar(DetalleMatricula detalle) {
        dao.update(detalle);
    }

    @Override
    public void eliminar(int id) {
        dao.delete(id);
    }

    @Override
    public List<DetalleMatricula> listarPorMatricula(int idMatricula) {
        return dao.findByMatricula(idMatricula);
    }
}
