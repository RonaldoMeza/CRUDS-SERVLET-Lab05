package com.tecsup.lab05.services.Impl;

import com.tecsup.lab05.model.daos.MatriculaDao;
import com.tecsup.lab05.model.daos.DetalleMatriculaDao;
import com.tecsup.lab05.model.daos.Impl.DaoFactory;
import com.tecsup.lab05.model.entities.Matricula;
import com.tecsup.lab05.services.MatriculaService;
import com.tecsup.lab05.util.DBConn;
import com.tecsup.lab05.util.Util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class MatriculaServiceImpl implements MatriculaService {

    private MatriculaDao matriculaDao;
    private DetalleMatriculaDao detalleDao;

    public MatriculaServiceImpl() {
        this.matriculaDao = DaoFactory.getMatriculaDao(Util.opc);
        this.detalleDao = DaoFactory.getDetalleMatriculaDao(Util.opc);
        System.out.println("[MatriculaServiceImpl] Constructor - matriculaDao is " + (matriculaDao != null ? "OK" : "NULL")
                + ", detalleDao is " + (detalleDao != null ? "OK" : "NULL"));
    }

    @Override
    public int crearMatriculaConCursos(String chrAluCodigo, int idPeriodo, List<String> codigosCursos) throws Exception {
        // Transacción manual usando SP sp_ins_matricula (OUT) y sp_ins_detalle_matricula
        String spInsMat = "{call sp_ins_matricula(?, ?, ?)}"; // IN chrAluCodigo, IN idPeriodo, OUT newId
        String spInsDet = "{call sp_ins_detalle_matricula(?, ?)}"; // IN idMatricula, IN chrCurCodigo

        Connection conn = null;
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            int idMatricula;
            try (CallableStatement csMat = conn.prepareCall(spInsMat)) {
                csMat.setString(1, chrAluCodigo);
                csMat.setInt(2, idPeriodo);
                csMat.registerOutParameter(3, Types.INTEGER);
                csMat.execute();
                idMatricula = csMat.getInt(3);
            }

            try (CallableStatement csDet = conn.prepareCall(spInsDet)) {
                if (codigosCursos != null) {
                    for (String cur : codigosCursos) {
                        csDet.setInt(1, idMatricula);
                        csDet.setString(2, cur);
                        csDet.executeUpdate();
                    }
                }
            }

            conn.commit();
            System.out.println("[MatriculaServiceImpl] crearMatriculaConCursos -> OK id=" + idMatricula);
            return idMatricula;
        } catch (SQLException ex) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e) { /* log */ }
            }
            System.out.println("[MatriculaServiceImpl] Error crearMatriculaConCursos: " + ex.getMessage());
            throw new Exception("Error creando matrícula: " + ex.getMessage(), ex);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) { /* log */ }
            }
        }
    }

    @Override
    public void actualizar(Matricula m) throws Exception {
        try {
            matriculaDao.update(m);
        } catch (Exception ex) {
            System.out.println("[MatriculaServiceImpl] Error en actualizar: " + ex.getMessage());
            throw ex;
        }
    }


    @Override
    public void eliminar(int id) throws Exception {
        if (matriculaDao == null) throw new Exception("matriculaDao no inicializado");
        try {
            System.out.println("[MatriculaServiceImpl] eliminar -> llamando matriculaDao.delete(" + id + ")");
            matriculaDao.delete(id); // espera que el DAO invoque sp_retirar_matricula
            System.out.println("[MatriculaServiceImpl] eliminar -> completado para id=" + id);
        } catch (Exception ex) {
            System.out.println("[MatriculaServiceImpl] Error eliminar: " + ex.getMessage());
            throw ex;
        }
    }

    @Override
    public List<Matricula> listar() throws Exception {
        if (matriculaDao == null) return new ArrayList<>();
        return matriculaDao.findAll();
    }

    @Override
    public Matricula buscar(int id) throws Exception {
        if (matriculaDao == null) return null;
        return matriculaDao.find(id);
    }
}
