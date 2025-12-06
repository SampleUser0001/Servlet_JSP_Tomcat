package ittimfn.sample.tomcat.blob;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/images")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ImageUploadServlet extends HttpServlet {

    private static final Logger logger = LogManager.getLogger(ImageUploadServlet.class);
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called - listing images");

        try {
            List<Image> images = getAllImages();
            request.setAttribute("images", images);
            request.getRequestDispatcher("/WEB-INF/images.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.error("Failed to retrieve images", e);
            request.setAttribute("error", "画像の取得に失敗しました: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/images.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doPost called - uploading image");

        try {
            // Get title parameter
            request.setCharacterEncoding("UTF-8");
            String title = request.getParameter("title");

            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "タイトルを入力してください");
                doGet(request, response);
                return;
            }

            Part filePart = request.getPart("image");
            logger.debug("filePart: {}", filePart);

            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("error", "画像ファイルを選択してください");
                doGet(request, response);
                return;
            }

            String fileName = getFileName(filePart);
            String contentType = filePart.getContentType();

            logger.debug("contentType: {}", contentType);

            // Validate content type
            if (!isValidImageType(contentType)) {
                request.setAttribute("error", "画像ファイル(PNG, JPG, GIF)のみアップロード可能です");
                doGet(request, response);
                return;
            }

            // Read image data
            byte[] imageData = readInputStream(filePart.getInputStream());

            // Save to database
            saveImage(title, fileName, contentType, imageData);

            logger.info("Image uploaded successfully: {} ({})", title, fileName);
            request.setAttribute("success", "画像のアップロードに成功しました");

            // Redirect to avoid form resubmission
            response.sendRedirect(request.getContextPath() + "/images");

        } catch (Exception e) {
            logger.error("Failed to upload image", e);
            request.setAttribute("error", "画像のアップロードに失敗しました: " + e.getMessage());
            doGet(request, response);
        }
    }

    private List<Image> getAllImages() throws SQLException {
        List<Image> images = new ArrayList<>();
        String sql = "SELECT id, title, name, content_type, file_size, uploaded_at FROM images ORDER BY uploaded_at DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Image image = new Image();
                image.setId(rs.getInt("id"));
                image.setTitle(rs.getString("title"));
                image.setName(rs.getString("name"));
                image.setContentType(rs.getString("content_type"));
                image.setFileSize(rs.getLong("file_size"));
                image.setUploadedAt(rs.getTimestamp("uploaded_at"));
                images.add(image);
            }
        }

        return images;
    }

    private void saveImage(String title, String fileName, String contentType, byte[] imageData) throws SQLException {
        String sql = "INSERT INTO images (title, name, content_type, image_data, file_size) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, title);
            stmt.setString(2, fileName);
            stmt.setString(3, contentType);
            stmt.setBytes(4, imageData);
            stmt.setLong(5, imageData.length);

            stmt.executeUpdate();
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");

        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                String fileName = element.substring(element.indexOf('=') + 1).trim()
                        .replace("\"", "");
                return fileName;
            }
        }

        return "unknown";
    }

    private boolean isValidImageType(String contentType) {
        return contentType != null &&
               (contentType.equals("image/jpeg") ||
                contentType.equals("image/jpg") ||
                contentType.equals("image/png") ||
                contentType.equals("image/gif") || 
                contentType.equals("text/plain"));
    }

    private byte[] readInputStream(InputStream inputStream) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] data = new byte[1024];
        int bytesRead;

        while ((bytesRead = inputStream.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, bytesRead);
        }

        buffer.flush();
        return buffer.toByteArray();
    }
}
