package ittimfn.sample.tomcat.blob;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class DatabaseUtil {

    private static final Logger logger = LogManager.getLogger(DatabaseUtil.class);

    // H2 Database configuration (embedded mode)
    private static final String DB_URL = "jdbc:h2:~/imagedb;DB_CLOSE_DELAY=-1";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    static {
        try {
            // Load H2 Driver
            Class.forName("org.h2.Driver");
            logger.info("H2 Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            logger.error("Failed to load H2 Driver", e);
            throw new RuntimeException("Failed to load H2 Driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static void shutdown() {
        try (Connection conn = getConnection();
             java.sql.Statement stmt = conn.createStatement()) {
            stmt.execute("SHUTDOWN");
            logger.info("Database shutdown successfully");
        } catch (SQLException e) {
            logger.error("Error shutting down database", e);
        }
    }
}
