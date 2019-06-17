package util;

import org.omg.CORBA.DATA_CONVERSION;

import java.sql.*;

public class DatabaseHelper
{
//    private final String DB_URL = "jdbc:mysql://122.114.119.101:3306/xm07_2019?useUnicode=true&characterEncoding=UTF-8";
    private final String DB_URL = "jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=UTF-8";
    private final String DB_USR = "root";
    private final String DB_PASS = "123456";
//    private final String DB_USR = "xm07";
//    private final String DB_PASS = "YJYkfsj2019";

    private Connection conn = null;
    private Statement st = null;

    public DatabaseHelper()
    {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USR, DB_PASS);
            st = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void finalize()
    {
        try {
            st.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean execute(String sql)
    {
        boolean ret = false;
        try {
            ret = st.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ret;
    }

    public ResultSet executeQuery(String sql)
    {
        ResultSet ret = null;
        try {
            ret = st.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ret;
    }
    public void executeUpdate(String s) {
        try {
            st.executeUpdate(s);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
