package com.tecsup.lab05.model.entities;

import java.util.Date;

public class PeriodoAcademico {
    private int idPeriodo;
    private String nombrePeriodo;
    private Date fechaInicio;
    private Date fechaFin;
    private String estado;

    public PeriodoAcademico(){}

    public PeriodoAcademico(int idPeriodo, String nombrePeriodo, Date fechaInicio, Date fechaFin, String estado) {
        this.idPeriodo = idPeriodo;
        this.nombrePeriodo = nombrePeriodo;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.estado = estado;
    }

    public int getIdPeriodo() { return idPeriodo; }
    public void setIdPeriodo(int idPeriodo) { this.idPeriodo = idPeriodo; }
    public String getNombrePeriodo() { return nombrePeriodo; }
    public void setNombrePeriodo(String nombrePeriodo) { this.nombrePeriodo = nombrePeriodo; }
    public Date getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(Date fechaInicio) { this.fechaInicio = fechaInicio; }
    public Date getFechaFin() { return fechaFin; }
    public void setFechaFin(Date fechaFin) { this.fechaFin = fechaFin; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    @Override
    public String toString() {
        return "PeriodoAcademico{" +
                "idPeriodo=" + idPeriodo +
                ", nombrePeriodo='" + nombrePeriodo + '\'' +
                ", fechaInicio=" + fechaInicio +
                ", fechaFin=" + fechaFin +
                ", estado='" + estado + '\'' +
                '}';
    }
}
