package com.tecsup.lab05.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBConn.getConnection()) {
            if (conn != null) {
                System.out.println("✅ Conexión OK!");

                // --- prueba rápida: listar bases de datos ---
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SHOW DATABASES");
                System.out.println("Bases de datos disponibles:");
                while (rs.next()) {
                    System.out.println(" - " + rs.getString(1));
                }
            } else {
                System.out.println("❌ No se pudo obtener conexión.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
