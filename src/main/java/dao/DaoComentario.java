package dao;

import entidades.Comentario;
import utils.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoComentario {

    public static List<Comentario> consultarAprovadosPorPost(int idPost) {
        List<Comentario> lista = new ArrayList<Comentario>();
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return lista;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from comentario where id_postagem = ? and aprovado = true");
            stm.setInt(1, idPost);
            ResultSet rs = stm.executeQuery();

            while ( rs.next() ) {
                Comentario c = new Comentario(rs.getInt("id"),
                        rs.getInt("id_postagem"),
                        rs.getString("autor"),
                        rs.getString("conteudo"));

                lista.add(c);
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    public static List<Comentario> consultarReprovadosPorPost(int idPost) {
        List<Comentario> lista = new ArrayList<Comentario>();
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return lista;
        }

        try {
            PreparedStatement stm = con.prepareStatement("select * from comentario where id_postagem = ? and aprovado = false");
            stm.setInt(1, idPost);
            ResultSet rs = stm.executeQuery();

            while ( rs.next() ) {
                Comentario c = new Comentario(rs.getInt("id"),
                        rs.getInt("id_postagem"),
                        rs.getString("autor"),
                        rs.getString("conteudo"));

                lista.add(c);
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    public static void salvar(Comentario c) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("INSERT INTO comentario(id_postagem, autor, conteudo, aprovado) VALUES(?, ?, ?, ?)");
            stm.setInt(1, c.getIdPostagem());
            stm.setString(2, c.getAutor());
            stm.setString(3, c.getConteudo());
            stm.setBoolean(4, false);

            stm.execute();

        } catch(SQLException e) {
            return;
        }
    }

    public static void aprovaComentario( int id ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("UPDATE comentario SET aprovado = TRUE WHERE id = ?");
            stm.setInt(1, id);
            stm.execute();
        } catch(SQLException e) {
            return;
        }
    }

    public static void deletaComentario( int id ) {
        Connection con = Conexao.conectar();

        if ( con == null ) {
            return;
        }

        try {
            PreparedStatement stm = con.prepareStatement("DELETE FROM comentario WHERE id = ?");
            stm.setInt(1, id);
            stm.execute();
        } catch(SQLException e) {
            return;
        }
    }
}
