package ittimfn.sample.tomcat.radio;

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

    private static final Logger logger = LogManager.getLogger(IndexServlet.class);

    public static final String SELECT_KEY = "sample_select";
    public static final String OPTIONS_KEY = "options";
    public static final String SELECTED_OPTION_KEY = "selected_option";

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");
        forwardWithSelection(request, response, OptionsEnum.getDefault());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.debug("doPost called");

        OptionsEnum option = OptionsEnum.fromValue(Util.nullToEmpty(request.getParameter(SELECT_KEY)));
        logger.info("Selected option: {}", option);

        forwardWithSelection(request, response, option);
    }

    private void forwardWithSelection(HttpServletRequest request, HttpServletResponse response, OptionsEnum option)
            throws ServletException, IOException {
        request.setAttribute(SELECT_KEY, option.getValue());
        request.setAttribute(OPTIONS_KEY, OptionsEnum.asList());
        request.setAttribute(SELECTED_OPTION_KEY, option);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}
