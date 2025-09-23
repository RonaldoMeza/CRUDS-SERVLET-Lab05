package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.*;
import com.tecsup.lab05.util.Tipo;

public class DaoFactory {

    // ADMINISTRADOR
    public static AdministradorDao getAdministradorDao(Tipo tipo){
        switch (tipo){
            case MEM:
                return null;
            case PST:
                return null;
            case CST:
                return new AdministradorDaoCallableStatement();
            default:
                return null;
        }
    }

    // CURSO
    public static CursoDao getCursoDao(Tipo tipo){
        switch (tipo){
            case MEM:
                return null;
            case PST:
                return null;
            case CST:
                return new CursoDaoCallableStatement();
            default:
                return null;
        }
    }
    public static PeriodoDao getPeriodoDao(Tipo tipo){
        switch (tipo){
            case CST:
                return new PeriodoDaoCallableStatement();
            default:
                return null;
        }
    }

    public static MatriculaDao getMatriculaDao(Tipo tipo){
        switch (tipo){
            case CST:
                return new MatriculaDaoCallableStatement();
            default:
                return null;
        }
    }

    public static DetalleMatriculaDao getDetalleMatriculaDao(Tipo tipo){
        switch (tipo){
            case CST:
                return new DetalleMatriculaDaoCallableStatement();
            default:
                return null;
        }
    }

}
