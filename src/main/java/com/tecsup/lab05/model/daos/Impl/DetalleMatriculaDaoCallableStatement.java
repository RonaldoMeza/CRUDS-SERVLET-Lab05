package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.DetalleMatriculaDao;
import com.tecsup.lab05.model.entities.DetalleMatricula;
import com.tecsup.lab05.util.DBConn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DetalleMatriculaDaoCallableStatement implements DetalleMatriculaDao {
    @Override
    public List<DetalleMatricula> findAll() {
        // No usado; preferimos listar por matrícula
        return new ArrayList<>();
    }

    @Override
    public void create(DetalleMatricula detalle) {
        String sql = "{call sp_ins_detalle_matricula(?,?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, detalle.getIdMatricula());
            cst.setString(2, detalle.getChrCurCodigo());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en insertar Detalle: " + e.getMessage());
        }
    }

    @Override
    public DetalleMatricula find(Integer id) {
        // opcional
        return null;
    }

    @Override
    public void update(DetalleMatricula detalle) {
        // opcional - usar sp_retirar_detalle
        String sql = "{call sp_retirar_detalle(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, detalle.getIdDetalle());
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en update Detalle: " + e.getMessage());
        }
    }

    @Override
    public void delete(Integer id) {
        // usar sp_retirar_detalle
        String sql = "{call sp_retirar_detalle(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, id);
            cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error en delete Detalle: " + e.getMessage());
        }
    }

    @Override
    public List<DetalleMatricula> findByMatricula(int idMatricula) {
        List<DetalleMatricula> list = new ArrayList<>();
        String sql = "{call sp_findAll_detalle_by_matricula(?)}";
        try (Connection con = DBConn.getConnection();
             CallableStatement cst = con.prepareCall(sql)) {
            cst.setInt(1, idMatricula);
            try (ResultSet rs = cst.executeQuery()) {
                while (rs.next()) {
                    DetalleMatricula d = new DetalleMatricula(
                            rs.getInt("idDetalle"),
                            rs.getInt("idMatricula"),
                            rs.getString("chrCurCodigo"),
                            rs.getString("chrDetEstado")
                    );
                    list.add(d);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en findByMatricula Detalle: " + e.getMessage());
        }
        return list;
    }
}
