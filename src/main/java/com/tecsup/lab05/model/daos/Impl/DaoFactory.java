package com.tecsup.lab05.model.daos.Impl;

import com.tecsup.lab05.model.daos.AdministradorDao;
import com.tecsup.lab05.model.daos.CursoDao;
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
}
