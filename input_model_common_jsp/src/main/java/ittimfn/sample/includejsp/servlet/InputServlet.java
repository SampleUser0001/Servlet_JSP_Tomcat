package ittimfn.sample.includejsp.servlet;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/input")
public class InputServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(InputServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        Common.getAndSetAttribute(request);
        request.getRequestDispatcher("/WEB-INF/init.jsp").forward(request, response);
    }

}
