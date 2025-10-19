package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

import static ittimfn.servlet.BookData.ALL_BOOKS;

/**
 * 書籍詳細表示サーブレット
 */
public class BookDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String bookId = request.getParameter("id");

        if (bookId == null || bookId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bookSearch");
            return;
        }

        // IDで書籍を検索
        Optional<Book> bookOpt = ALL_BOOKS.stream()
            .filter(book -> book.getId().equals(bookId))
            .findFirst();

        if (bookOpt.isPresent()) {
            request.setAttribute("book", bookOpt.get());
            request.getRequestDispatcher("/jsp/bookDetail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "書籍が見つかりませんでした");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
