package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import util.DbConnectionUtil;
import java.sql.Connection;

@WebListener
public class DatabaseConnectionListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("DatabaseConnectionListener: Initializing database connection...");
        Connection conn = DbConnectionUtil.getConnection();
        if (conn != null) {
            sce.getServletContext().setAttribute("DBConnection", conn);
            System.out.println("DatabaseConnectionListener: Database connection initialized and stored in context");
        } else {
            System.err.println("DatabaseConnectionListener: Failed to initialize database connection");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("DatabaseConnectionListener: Closing database connection...");
        Connection conn = (Connection) sce.getServletContext().getAttribute("DBConnection");
        if (conn != null) {
            try {
                conn.close();
                System.out.println("DatabaseConnectionListener: Database connection closed");
            } catch (Exception e) {
                System.err.println("DatabaseConnectionListener: Error closing database connection");
                e.printStackTrace();
            }
        }
    }
} 