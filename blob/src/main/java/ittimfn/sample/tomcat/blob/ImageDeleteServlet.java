package ittimfn.sample.tomcat.blob;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/delete-image")
public class ImageDeleteServlet extends HttpServlet {

    private static final Logger logger = LogManager.getLogger(ImageDeleteServlet.class);
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/images?error=invalid_id");
            return;
        }

        try {
            int imageId = Integer.parseInt(idParam);
            boolean deleted = deleteImage(imageId);

            if (deleted) {
                logger.info("Image deleted successfully: id={}", imageId);
                response.sendRedirect(request.getContextPath() + "/images?success=deleted");
            } else {
                logger.warn("Image not found for deletion: id={}", imageId);
                response.sendRedirect(request.getContextPath() + "/images?error=not_found");
            }

        } catch (NumberFormatException e) {
            logger.error("Invalid image ID format: {}", idParam);
            response.sendRedirect(request.getContextPath() + "/images?error=invalid_id");
        } catch (SQLException e) {
            logger.error("Failed to delete image", e);
            response.sendRedirect(request.getContextPath() + "/images?error=delete_failed");
        }
    }

    private boolean deleteImage(int id) throws SQLException {
        String sql = "DELETE FROM images WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;
        }
    }
}
