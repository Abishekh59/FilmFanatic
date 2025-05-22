package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnectionUtil {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/filmfanatic_db"; // update if needed
    private static final String JDBC_USERNAME = "root"; // update if needed
    private static final String JDBC_PASSWORD = "12345";     // update if needed

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            System.out.println("✅ Database connected successfully.");
            return conn;
        } catch (Exception e) {
            System.err.println("❌ Database connection failed:");
            e.printStackTrace();
            return null;
        }
    }
}
