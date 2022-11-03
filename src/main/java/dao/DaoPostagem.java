package dao;

import entidades.Postagem;
import utils.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoPostagem {

    public static void salvar( Postagem p ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("INSERT INTO postagem(titulo, autor, conteudo) VALUES(?, ?, ?)");
            stm.setString(1, p.getTitulo());
            stm.setString(2, p.getAutor());
            stm.setString(3, p.getConteudo());

            stm.execute();
        } catch(SQLException e) {
            return;
        }
    }

    public static List<Postagem> consultar() {
        List<Postagem> lista = new ArrayList<Postagem>();
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return lista;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from postagem order by id desc");
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Postagem p = new Postagem(rs.getString("titulo"),
                                            rs.getString("autor"),
                                            rs.getString("conteudo"),
                                            rs.getInt("id"));

                lista.add(p);
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    public static Postagem consultar( int id ) {
        Connection con = Conexao.conectar();
        Postagem p = new Postagem();

        if ( con == null ) {
            return null;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from postagem where id = ?");
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if ( rs.next() ) {
                p.setId(rs.getInt("id"));
                p.setTitulo(rs.getString("titulo"));
                p.setAutor(rs.getString("autor"));
                p.setConteudo(rs.getString("conteudo"));
            } else {
                return null;
            }
        } catch(SQLException e) {
            return null;
        }

        return p;
    }

    public static void deletar( int id ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("DELETE FROM postagem WHERE id = ?");
            stm.setInt(1, id);
            stm.execute();
        } catch(SQLException e) {
            return;
        }
    }

    public static void editar( int id, Postagem p ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("UPDATE postagem SET titulo = ?, autor = ?, conteudo = ? WHERE id = ?");
            stm.setString(1, p.getTitulo());
            stm.setString(2, p.getAutor());
            stm.setString(3, p.getConteudo());
            stm.setInt(4, id);
            stm.execute();
        } catch(SQLException e) {
            return;
        }

    }
}
