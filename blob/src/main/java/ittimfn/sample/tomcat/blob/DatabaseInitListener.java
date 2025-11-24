package ittimfn.sample.tomcat.blob;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebListener
public class DatabaseInitListener implements ServletContextListener {

    private static final Logger logger = LogManager.getLogger(DatabaseInitListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("Initializing H2 database...");

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create images table
            String createTableSQL = "CREATE TABLE IF NOT EXISTS images (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255) NOT NULL, " +
                    "content_type VARCHAR(100) NOT NULL, " +
                    "image_data BLOB NOT NULL, " +
                    "file_size BIGINT NOT NULL, " +
                    "uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";

            stmt.execute(createTableSQL);
            logger.info("Database initialized successfully");

        } catch (Exception e) {
            logger.error("Failed to initialize database", e);
            throw new RuntimeException("Failed to initialize database", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("Shutting down H2 database...");
        DatabaseUtil.shutdown();
    }
}
