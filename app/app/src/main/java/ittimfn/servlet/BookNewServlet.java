package ittimfn.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;

/**
 * 書籍新規登録画面表示サーブレット
 */
public class BookNewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Logger logger = LogManager.getLogger(BookNewServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 新規登録画面を表示
        request.getRequestDispatcher("/jsp/bookNew.jsp").forward(request, response);
    }

}
