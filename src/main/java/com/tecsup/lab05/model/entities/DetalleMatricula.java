package com.tecsup.lab05.model.entities;

public class DetalleMatricula {
    private int idDetalle;
    private int idMatricula;
    private String chrCurCodigo;
    private String estado;

    public DetalleMatricula(){}

    public DetalleMatricula(int idDetalle, int idMatricula, String chrCurCodigo, String estado) {
        this.idDetalle = idDetalle;
        this.idMatricula = idMatricula;
        this.chrCurCodigo = chrCurCodigo;
        this.estado = estado;
    }

    public int getIdDetalle() { return idDetalle; }
    public void setIdDetalle(int idDetalle) { this.idDetalle = idDetalle; }
    public int getIdMatricula() { return idMatricula; }
    public void setIdMatricula(int idMatricula) { this.idMatricula = idMatricula; }
    public String getChrCurCodigo() { return chrCurCodigo; }
    public void setChrCurCodigo(String chrCurCodigo) { this.chrCurCodigo = chrCurCodigo; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    @Override
    public String toString() {
        return "DetalleMatricula{" +
                "idDetalle=" + idDetalle +
                ", idMatricula=" + idMatricula +
                ", chrCurCodigo='" + chrCurCodigo + '\'' +
                ", estado='" + estado + '\'' +
                '}';
    }
}
