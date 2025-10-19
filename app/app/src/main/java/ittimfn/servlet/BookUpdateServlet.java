package ittimfn.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.model.Book;

public class BookUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static Logger logger = LogManager.getLogger(BookUpdateServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // フォームから値を取得
        Book book = BookUtils.getBookParams(request);
        // バリデーション
        if (!BookUtils.validateBook(book)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "必須項目が入力されていません");
            return;
        }
        try {
            int year = book.getYear();
            String bookId = book.getId();

            // 更新する書籍オブジェクトを作成
            Book updatedBook = new Book(bookId, book.getTitle(), book.getAuthor(), book.getGenre(), year);
            logger.info("書籍情報を更新: {}", updatedBook);

            // リストの書籍情報を更新（本来はDBに保存）
            boolean updated = BookData.updateBook(updatedBook);

            if (!updated) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "書籍が見つかりませんでした");
                return;
            }

            // 検索画面にリダイレクト
            response.sendRedirect(request.getContextPath() + "/bookSearch");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "出版年は数値で入力してください");
        }
    }
}
