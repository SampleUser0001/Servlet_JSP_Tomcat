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
 * 書籍検索ポップアップサーブレット
 * 子画面として検索機能を提供し、検索結果をハイライト表示する
 */
public class BookSearchPopupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Logger logger = LogManager.getLogger(BookSearchPopupServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String keyword = request.getParameter("keyword");
        String genre = request.getParameter("genre");

        logger.info("検索リクエスト - キーワード: {}, ジャンル: {}", keyword, genre);

        List<Book> searchResults = null;

        // キーワードまたはジャンルが指定されている場合のみ検索
        if ((keyword != null && !keyword.isEmpty()) || (genre != null && !genre.isEmpty())) {
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

            logger.info("検索結果: {}件", searchResults.size());
        }

        request.setAttribute("books", searchResults);
        request.setAttribute("keyword", keyword != null ? keyword : "");
        request.setAttribute("genre", genre != null ? genre : "");

        request.getRequestDispatcher("/jsp/bookSearchPopup.jsp").forward(request, response);
    }
}
