package nefu.db;

import java.sql.*;

public class conndb {
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    private int i = 0;
    private String url = "jdbc:mysql://localhost:3306?allowPublicKeyRetrieval=true&serverTimezone=UTC";
    public conndb(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection(url,"root","root");
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public int update(String sql){
        try {
            i = stmt.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public ResultSet query(String sql){
        try {
            rs=stmt.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public void dbclose(){
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
