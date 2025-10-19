package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import static ittimfn.servlet.BookData.ALL_BOOKS;

/**
 * 書籍検索サーブレット
 */
public class BookSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Logger logger = LogManager.getLogger(BookSearchServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String keyword = request.getParameter("keyword");
        String genre = request.getParameter("genre");

        List<Book> searchResults;

        if (keyword == null && genre == null) {
            // 初回アクセス時は全件表示
            searchResults = ALL_BOOKS;
        } else {
            // 検索処理
            searchResults = ALL_BOOKS.stream()
                .filter(book -> {
                    boolean matchKeyword = keyword == null || keyword.isEmpty() ||
                        book.getTitle().contains(keyword) ||
                        book.getAuthor().contains(keyword);

                    boolean matchGenre = genre == null || genre.isEmpty() ||
                        book.getGenre().equals(genre);

                    return matchKeyword && matchGenre;
                })
                .collect(Collectors.toList());
        }

        request.setAttribute("books", searchResults);
        request.setAttribute("keyword", keyword != null ? keyword : "");
        request.setAttribute("genre", genre != null ? genre : "");

        request.getRequestDispatcher("/jsp/bookSearch.jsp").forward(request, response);
    }
}
