package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.AlumnoDao;
import com.tecsup.lab05.model.entities.Alumno;
import com.tecsup.lab05.util.DBConn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlumnoDaoCallableStatement implements AlumnoDao {

    @Override
    public List<Alumno> findAll() {
        List<Alumno> alumnos = new ArrayList<>();
        String sql = "{call sp_findAll_alumno()}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql);
             ResultSet rs = cst.executeQuery()) {
            while (rs.next()) {
                alumnos.add(new Alumno(
                        rs.getString("chrAluCodigo"),
                        rs.getString("vchAluNombres"),
                        rs.getString("vchAluApellidos")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error en findAll Alumno: " + e.getMessage());
        }
        return alumnos;
    }

    @Override
    public void create(Alumno alumno) {
        String sql = "{call sp_ins_alumno(?,?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, alumno.getCodigo());
            cst.setString(2, alumno.getNombres());
            cst.setString(3, alumno.getApellidos());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en insertar Alumno: " + e.getMessage());
        }
    }

    @Override
    public Alumno find(String id) {
        Alumno alumno = null;
        String sql = "{call sp_find_alumno(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, id);
            try (ResultSet rs = cst.executeQuery()) {
                if (rs.next()) {
                    alumno = new Alumno(
                            rs.getString("chrAluCodigo"),
                            rs.getString("vchAluNombres"),
                            rs.getString("vchAluApellidos")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en find Alumno: " + e.getMessage());
        }
        return alumno;
    }

    @Override
    public void update(Alumno alumno) {
        String sql = "{call sp_upd_alumno(?,?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, alumno.getCodigo());
            cst.setString(2, alumno.getNombres());
            cst.setString(3, alumno.getApellidos());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en update Alumno: " + e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "{call sp_del_alumno(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, id);
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en delete Alumno: " + e.getMessage());
        }
    }

    @Override
    public List<Alumno> findByApellido(String apellido) {
        List<Alumno> alumnos = new ArrayList<>();
        String sql = "{call sp_findByApellido_alumno(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setString(1, apellido);
            try (ResultSet rs = cst.executeQuery()) {
                while (rs.next()) {
                    alumnos.add(new Alumno(
                            rs.getString("chrAluCodigo"),
                            rs.getString("vchAluNombres"),
                            rs.getString("vchAluApellidos")
                    ));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en findByApellido Alumno: " + e.getMessage());
        }
        return alumnos;
    }
}
