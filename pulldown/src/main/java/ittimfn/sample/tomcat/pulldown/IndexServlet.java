package ittimfn.sample.tomcat.pulldown;

import java.io.IOException;
import java.nio.file.OpenOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.sample.tomcat.pulldown.OptionsEnum;

@WebServlet("/")
public class IndexServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(IndexServlet.class);

    private static final long serialVersionUID = 1L;

    public static final String SELECT_KEY = "sample_select";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");
        request.setAttribute(SELECT_KEY, OptionsEnum.getDefault().getValue());
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.debug("doPost called");

        OptionsEnum option = OptionsEnum.fromValue(Util.nullToEmpty(request.getParameter(SELECT_KEY)));
        logger.info("Selected option: " + option);

        request.setAttribute(SELECT_KEY, option.getValue());
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

}
