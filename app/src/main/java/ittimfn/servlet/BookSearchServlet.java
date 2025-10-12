package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 書籍検索サーブレット
 */
public class BookSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // サンプルデータ（本来はDBから取得）
    private static final List<Book> ALL_BOOKS = new ArrayList<>();

    static {
        ALL_BOOKS.add(new Book("B001", "Javaプログラミング入門", "山田太郎", "技術書", 2020));
        ALL_BOOKS.add(new Book("B002", "データベース設計", "佐藤花子", "技術書", 2019));
        ALL_BOOKS.add(new Book("B003", "Web開発の基礎", "鈴木一郎", "技術書", 2021));
        ALL_BOOKS.add(new Book("B004", "デザインパターン", "田中次郎", "技術書", 2018));
        ALL_BOOKS.add(new Book("B005", "アルゴリズム入門", "高橋三郎", "技術書", 2022));
        ALL_BOOKS.add(new Book("B006", "Python実践ガイド", "伊藤美咲", "技術書", 2021));
        ALL_BOOKS.add(new Book("B007", "ネットワークの基礎", "渡辺健", "技術書", 2020));
        ALL_BOOKS.add(new Book("B008", "セキュリティ入門", "中村真理", "技術書", 2023));
    }

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
