package dao;

import entidades.Usuario;
import utils.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUsuario {

    public static boolean verificarLogin( String usuario, String senha ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return false;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from usuario where login = ? and senha = ?");
            stm.setString(1, usuario);
            stm.setString(2, senha);
            ResultSet rs = stm.executeQuery();

            if ( rs.next() ) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            return false;
        }
    }

    public static boolean verificarModerador( String usuario ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return false;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from usuario where moderador = true and login = ?");
            stm.setString(1, usuario);
            ResultSet rs = stm.executeQuery();

            if ( rs.next() ) {
                return true;
            }

            return false;
        } catch(SQLException e) {
            return false;
        }
    }

    public static boolean verificarUsuario( String usuario ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return true;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from usuario where login = ?");
            stm.setString(1, usuario);
            ResultSet rs = stm.executeQuery();

            if ( rs.next() ) {
                return true;
            }

            return false;
        } catch(SQLException e) {
            return true;
        }
    }

    public static void salvar( Usuario u ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("INSERT INTO usuario(login, senha, moderador) VALUES(?, ?, ?);");
            stm.setString(1, u.getLogin());
            stm.setString(2, u.getSenha());
            stm.setBoolean(3, u.isModerador());

            stm.execute();
        } catch(SQLException e) {
            return;
        }
    }
}
