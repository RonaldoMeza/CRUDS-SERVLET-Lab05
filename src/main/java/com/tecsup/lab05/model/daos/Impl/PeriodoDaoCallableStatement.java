package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.PeriodoDao;
import com.tecsup.lab05.model.entities.PeriodoAcademico;
import com.tecsup.lab05.util.DBConn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PeriodoDaoCallableStatement implements PeriodoDao {
    private ResultSet rs;

    @Override
    public List<PeriodoAcademico> findAll() {
        List<PeriodoAcademico> list = new ArrayList<>();
        String sql = "{call sp_findAll_periodo()}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql);
             ResultSet rs = cst.executeQuery()) {
            while (rs.next()) {
                PeriodoAcademico p = new PeriodoAcademico(
                        rs.getInt("idPeriodo"),
                        rs.getString("vchPerNombre"),
                        rs.getDate("dtmPerFechaInicio"),
                        rs.getDate("dtmPerFechaFin"),
                        rs.getString("chrPerEstado")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error en findAll Periodo: " + e.getMessage());
        }
        return list;
    }

    @Override
    public void create(PeriodoAcademico periodo) {
        String sql = "{call sp_ins_periodo(?,?,?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, periodo.getNombrePeriodo());
            cst.setDate(2, new java.sql.Date(periodo.getFechaInicio().getTime()));
            cst.setDate(3, new java.sql.Date(periodo.getFechaFin().getTime()));
            cst.setString(4, periodo.getEstado());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en insertar Periodo: " + e.getMessage());
        }
    }

    @Override
    public PeriodoAcademico find(Integer id) {
        PeriodoAcademico p = null;
        String sql = "{call sp_find_periodo(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, id);
            try (ResultSet rs = cst.executeQuery()) {
                if (rs.next()) {
                    p = new PeriodoAcademico(
                            rs.getInt("idPeriodo"),
                            rs.getString("vchPerNombre"),
                            rs.getDate("dtmPerFechaInicio"),
                            rs.getDate("dtmPerFechaFin"),
                            rs.getString("chrPerEstado")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en find Periodo: " + e.getMessage());
        }
        return p;
    }

    @Override
    public void update(PeriodoAcademico periodo) {
        String sql = "{call sp_upd_periodo(?,?,?,?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, periodo.getIdPeriodo());
            cst.setString(2, periodo.getNombrePeriodo());
            cst.setDate(3, new java.sql.Date(periodo.getFechaInicio().getTime()));
            cst.setDate(4, new java.sql.Date(periodo.getFechaFin().getTime()));
            cst.setString(5, periodo.getEstado());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en update Periodo: " + e.getMessage());
        }
    }

    @Override
    public void delete(Integer id) {
        String sql = "{call sp_del_periodo(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, id);
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en delete Periodo: " + e.getMessage());
        }
    }
}
