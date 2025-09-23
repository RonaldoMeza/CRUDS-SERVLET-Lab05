package com.tecsup.lab05.model.entities;

import java.util.Date;

public class Matricula {
    private int idMatricula;
    private String chrAluCodigo;
    private int idPeriodo;
    private Date fechaMatricula;
    private String estado;

    public Matricula(){}

    public Matricula(int idMatricula, String chrAluCodigo, int idPeriodo, Date fechaMatricula, String estado) {
        this.idMatricula = idMatricula;
        this.chrAluCodigo = chrAluCodigo;
        this.idPeriodo = idPeriodo;
        this.fechaMatricula = fechaMatricula;
        this.estado = estado;
    }

    public int getIdMatricula() { return idMatricula; }
    public void setIdMatricula(int idMatricula) { this.idMatricula = idMatricula; }
    public String getChrAluCodigo() { return chrAluCodigo; }
    public void setChrAluCodigo(String chrAluCodigo) { this.chrAluCodigo = chrAluCodigo; }
    public int getIdPeriodo() { return idPeriodo; }
    public void setIdPeriodo(int idPeriodo) { this.idPeriodo = idPeriodo; }
    public Date getFechaMatricula() { return fechaMatricula; }
    public void setFechaMatricula(Date fechaMatricula) { this.fechaMatricula = fechaMatricula; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    @Override
    public String toString() {
        return "Matricula{" +
                "idMatricula=" + idMatricula +
                ", chrAluCodigo='" + chrAluCodigo + '\'' +
                ", idPeriodo=" + idPeriodo +
                ", fechaMatricula=" + fechaMatricula +
                ", estado='" + estado + '\'' +
                '}';
    }
}
