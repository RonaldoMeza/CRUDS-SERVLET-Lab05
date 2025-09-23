package com.tecsup.lab05.services.Impl;

import com.tecsup.lab05.model.entities.Matricula;
import com.tecsup.lab05.util.DBConn;
import com.tecsup.lab05.services.MatriculaService;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

public class MatriculaServiceImpl implements MatriculaService {

    @Override
    public int crearMatriculaConCursos(String chrAluCodigo, int idPeriodo, List<String> codigosCursos) throws Exception {
        String spInsMat = "{call sp_ins_matricula(?, ?, ?)}";
        String spInsDet = "{call sp_ins_detalle_matricula(?, ?)}";
        Connection conn = null;
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            // insertar matricula y obtener id
            try (CallableStatement csMat = conn.prepareCall(spInsMat)) {
                csMat.setString(1, chrAluCodigo);
                csMat.setInt(2, idPeriodo);
                csMat.registerOutParameter(3, Types.INTEGER);
                csMat.execute();
            }
            int idMatricula;
            try (CallableStatement csGet = conn.prepareCall("{? = call LAST_INSERT_ID()}")) {
                // Some DBs don't allow this; simpler: get OUT param via first call
            }
            // MySQL: we obtained id via out parameter in csMat; but it's closed.
            // To keep code robust, re-call sp_ins_matricula with registered out param and read it:
            // But already executed above; retrieve using LAST_INSERT_ID() query:
            try (java.sql.Statement st = conn.createStatement();
                 java.sql.ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID() as id")) {
                rs.next();
                idMatricula = rs.getInt("id");
            }

            // insertar detalles
            try (CallableStatement csDet = conn.prepareCall(spInsDet)) {
                for (String cur : codigosCursos) {
                    csDet.setInt(1, idMatricula);
                    csDet.setString(2, cur);
                    csDet.executeUpdate();
                }
            }

            conn.commit();
            return idMatricula;
        } catch (SQLException ex) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException e) { /* log */ }
            }
            throw new Exception("Error creando matrícula: " + ex.getMessage(), ex);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { /* log */ }
            }
        }
    }

    @Override
    public void actualizar(Matricula m) throws Exception {

    }

    @Override
    public void eliminar(int id) throws Exception {

    }

    @Override
    public List<Matricula> listar() throws Exception {
        return null;
    }

    @Override
    public Matricula buscar(int id) throws Exception {
        return null;
    }
}
