package ittimfn.servlet;

import ittimfn.model.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 書籍新規登録処理サーブレット
 */
public class BookCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // サンプルデータ（本来はDBに保存）
    private static final List<Book> ALL_BOOKS = new ArrayList<>();
    private static int nextId = 9; // 次のID番号

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // フォームから値を取得
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String yearStr = request.getParameter("year");

        // バリデーション
        if (title == null || title.isEmpty() ||
            author == null || author.isEmpty() ||
            genre == null || genre.isEmpty() ||
            yearStr == null || yearStr.isEmpty()) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "必須項目が入力されていません");
            return;
        }

        try {
            int year = Integer.parseInt(yearStr);

            // 書籍IDを自動採番（B009, B010...）
            String bookId = String.format("B%03d", nextId++);

            // 新しい書籍オブジェクトを作成
            Book newBook = new Book(bookId, title, author, genre, year);

            // リストに追加（本来はDBに保存）
            ALL_BOOKS.add(newBook);

            // 検索画面にリダイレクト
            response.sendRedirect(request.getContextPath() + "/bookSearch");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "出版年は数値で入力してください");
        }
    }
}
