package ittimfn.sample.tomcat.pulldown;

import java.io.IOException;
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
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.debug("doPost called");

        String option = request.getParameter("options");
        request.setAttribute("sample_select", option);
        logger.info("Selected option: " + option);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

}
