package ittimfn.servlet.dynamicinput;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/inputPopup")
public class InputPopupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Logger logger = LogManager.getLogger(InputPopupServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called - ポップアップ画面を表示");
        request.getRequestDispatcher("/WEB-INF/inputPopup.jsp").forward(request, response);
    }
}
