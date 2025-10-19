package ittimfn.servlet;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.model.Book;

public class BookData {

    private static Logger logger = LogManager.getLogger(BookData.class);

    // サンプルデータ（本来はDBから取得）
    public static final List<Book> ALL_BOOKS = new ArrayList<>();
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

    public static boolean updateBook(Book updatedBook) {
        logger.info("ALL_BOOKS before update: {}", ALL_BOOKS);
        logger.info("Updating book: {}", updatedBook);
        for (int i = 0; i < ALL_BOOKS.size(); i++) {
            if (ALL_BOOKS.get(i).getId().equals(updatedBook.getId())) {

                logger.info("Before book: {}", ALL_BOOKS.get(i));

                ALL_BOOKS.set(i, updatedBook);

                logger.info("After book: {}", ALL_BOOKS.get(i));
                return true;
            }
        }
        return false;
    }

    public static int getNextId() {
        return nextId++;
    }
}
