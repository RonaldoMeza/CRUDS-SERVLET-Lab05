package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.MatriculaDao;
import com.tecsup.lab05.model.entities.Matricula;
import com.tecsup.lab05.util.DBConn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatriculaDaoCallableStatement implements MatriculaDao {
    @Override
    public List<Matricula> findAll() {
        List<Matricula> list = new ArrayList<>();
        String sql = "{call sp_findAll_matricula()}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql);
             ResultSet rs = cst.executeQuery()) {
            while (rs.next()) {
                Matricula m = new Matricula(
                        rs.getInt("idMatricula"),
                        rs.getString("chrAluCodigo"),
                        rs.getInt("idPeriodo"),
                        rs.getTimestamp("dtmFechaMatricula"),
                        rs.getString("chrMatEstado")
                );
                list.add(m);
            }
        } catch (SQLException e) {
            System.out.println("Error en findAll Matricula: " + e.getMessage());
        }
        return list;
    }

    @Override
    public void create(Matricula matricula) {
        // No usado en la creación con detalles (ver service transaccional).
        String sql = "{call sp_ins_matricula(?, ?, ?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, matricula.getChrAluCodigo());
            cst.setInt(2, matricula.getIdPeriodo());
            cst.registerOutParameter(3, Types.INTEGER);
            cst.execute();
            matricula.setIdMatricula(cst.getInt(3));
        } catch (SQLException e) {
            System.out.println("Error en insertar Matricula: " + e.getMessage());
        }
    }

    @Override
    public Matricula find(Integer id) {
        Matricula m = null;
        String sql = "{call sp_find_matricula(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, id);
            try (ResultSet rs = cst.executeQuery()) {
                if (rs.next()) {
                    m = new Matricula(
                            rs.getInt("idMatricula"),
                            rs.getString("chrAluCodigo"),
                            rs.getInt("idPeriodo"),
                            rs.getTimestamp("dtmFechaMatricula"),
                            rs.getString("chrMatEstado")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en find Matricula: " + e.getMessage());
        }
        return m;
    }

    @Override
    public void update(Matricula matricula) {
        String sql = "{call sp_upd_matricula_estado(?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, matricula.getIdMatricula());
            cst.setString(2, matricula.getEstado());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en update Matricula: " + e.getMessage());
        }
    }

    @Override
    public void delete(Integer id) {
        // baja lógica: marca la matrícula y todos sus detalles como 'retirado'
        String sql = "{call sp_retirar_matricula(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, id);
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en delete Matricula: " + e.getMessage());
        }
    }



    @Override
    public List<Matricula> findByAlumno(String chrAluCodigo) {
        // Implementación simple: filtrar en Java a partir de findAll o crear SP que acepte parámetro.
        List<Matricula> all = findAll();
        List<Matricula> out = new ArrayList<>();
        for (Matricula m : all) {
            if (m.getChrAluCodigo().equals(chrAluCodigo)) out.add(m);
        }
        return out;
    }
}
