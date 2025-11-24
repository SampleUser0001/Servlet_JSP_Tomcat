package ittimfn.sample.tomcat.blob;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/image")
public class ImageViewServlet extends HttpServlet {

    private static final Logger logger = LogManager.getLogger(ImageViewServlet.class);
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image ID is required");
            return;
        }

        try {
            int imageId = Integer.parseInt(idParam);
            Image image = getImageById(imageId);

            if (image == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                return;
            }

            // Set response headers
            response.setContentType(image.getContentType());
            response.setContentLength(image.getImageData().length);
            response.setHeader("Content-Disposition", "inline; filename=\"" + image.getName() + "\"");

            // Write image data to output stream
            try (OutputStream out = response.getOutputStream()) {
                out.write(image.getImageData());
                out.flush();
            }

            logger.debug("Image served successfully: id={}, name={}", imageId, image.getName());

        } catch (NumberFormatException e) {
            logger.error("Invalid image ID format: {}", idParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image ID");
        } catch (SQLException e) {
            logger.error("Failed to retrieve image", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve image");
        }
    }

    private Image getImageById(int id) throws SQLException {
        String sql = "SELECT id, name, content_type, image_data, file_size, uploaded_at FROM images WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Image image = new Image();
                    image.setId(rs.getInt("id"));
                    image.setName(rs.getString("name"));
                    image.setContentType(rs.getString("content_type"));
                    image.setImageData(rs.getBytes("image_data"));
                    image.setFileSize(rs.getLong("file_size"));
                    image.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    return image;
                }
            }
        }

        return null;
    }
}
