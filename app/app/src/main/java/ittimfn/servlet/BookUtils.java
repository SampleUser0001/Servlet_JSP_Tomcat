package ittimfn.servlet;

import javax.servlet.http.HttpServletRequest;

import ittimfn.model.Book;

public class BookUtils {
    
    public static Book getBookParams(HttpServletRequest request) {
        String id = request.getParameter("bookId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        int year = Integer.parseInt(request.getParameter("year"));
        return new Book(id, title, author, genre, year);
    }

    public static boolean validateBook(Book book) {
        return book.getTitle() != null && !book.getTitle().isEmpty() &&
               book.getAuthor() != null && !book.getAuthor().isEmpty() &&
               book.getGenre() != null && !book.getGenre().isEmpty() &&
               book.getYear() > 0;
    }

    private BookUtils() {
        // ユーティリティクラスのため、インスタンス化を防止
    }
}
