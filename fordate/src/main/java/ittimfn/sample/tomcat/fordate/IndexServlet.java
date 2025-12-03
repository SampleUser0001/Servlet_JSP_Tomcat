package ittimfn.sample.tomcat.fordate;

import java.io.IOException;
import java.nio.file.OpenOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/")
public class IndexServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(IndexServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        // セッションから日付データを取得（あれば）
        String date = (String) request.getSession().getAttribute("d");
        if (date != null) {
            request.setAttribute("d", date);
            // 取得後はセッションから削除（一度だけ表示）
            request.getSession().removeAttribute("d");
        }

        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.debug("doPost called");

        String date = request.getParameter("d");
        logger.info("date: {}", date);

        // セッションにデータを保存
        request.getSession().setAttribute("d", date);

        // GETリクエストにリダイレクト（PRGパターン）
        response.sendRedirect(request.getContextPath() + "/");
    }

}
