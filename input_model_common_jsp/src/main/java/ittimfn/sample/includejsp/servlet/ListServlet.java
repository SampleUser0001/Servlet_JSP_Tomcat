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

import ittimfn.sample.includejsp.datas.Datas;

@WebServlet("/")
public class ListServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(ListServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        request.setAttribute("list", Datas.DATA_LIST);
        
        request.getRequestDispatcher("/WEB-INF/list.jsp").forward(request, response);
    }

}
