package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {

    public static Connection conectar() {
        Connection con = null;

        String url = "jdbc:mysql://localhost/";
        String user = "";
        String pswd = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            con = DriverManager.getConnection(url, user, pswd);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return con;
    }
}
