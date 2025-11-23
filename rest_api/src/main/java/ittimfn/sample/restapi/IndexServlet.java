package ittimfn.sample.restapi;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.sample.restapi.enums.DataEnum;
import ittimfn.sample.restapi.model.DataModel;
import ittimfn.sample.restapi.model.ErrorModel;


@WebServlet("/data")
public class IndexServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(IndexServlet.class);

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        logger.debug("Requested ID: " + id);
        DataModel data = DataEnum.getData(id);
        if (data != null) {
            response.setContentType("application/json");
            response.getWriter().write(data.getJson());
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.setContentType("application/json");
            response.getWriter().write(new ErrorModel("Not Found").toJson());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.debug("doPost called");

    }

}
