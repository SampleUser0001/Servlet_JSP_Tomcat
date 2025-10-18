package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * 書籍詳細表示サーブレット
 */
public class BookDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // サンプルデータ（検索サーブレットと同じデータ）
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
