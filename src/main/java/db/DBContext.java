package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class DBContext {

    public Connection conn;

    public DBContext() {
        try {
            String user = "sa";
          String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=pawfect;encrypt=false";
            String pass = "khavy1711";// Đổi lại theo pass sa
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Connection getConnection() {
        return conn;
    }

    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement(query);

        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }
        }
        return preparedStatement.executeQuery();
    }

    public ResultSet execSelectQuery(String query) throws SQLException {
        return this.execSelectQuery(query, null);
    }

    public int execQuery(String query, Object[] params) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }

        }
        return preparedStatement.executeUpdate();
    }

}
