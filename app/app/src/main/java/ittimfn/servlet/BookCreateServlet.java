package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import static ittimfn.servlet.BookData.ALL_BOOKS;

/**
 * 書籍新規登録処理サーブレット
 */
public class BookCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Logger logger = LogManager.getLogger(BookCreateServlet.class);

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

            // 書籍IDを自動採番（B009, B010...）
            String bookId = String.format("B%03d", BookData.getNextId());

            // 新しい書籍オブジェクトを作成
            Book newBook = new Book(bookId, book.getTitle(), book.getAuthor(), book.getGenre(), year);
            logger.info("新規書籍作成: {}", newBook);

            // リストに追加（本来はDBに保存）
            ALL_BOOKS.add(newBook);

            // 検索画面にリダイレクト
            response.sendRedirect(request.getContextPath() + "/bookSearch");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "出版年は数値で入力してください");
        }
    }
}
