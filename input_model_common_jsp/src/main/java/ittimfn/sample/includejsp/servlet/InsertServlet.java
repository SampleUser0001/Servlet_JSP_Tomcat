package ittimfn.sample.includejsp.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.sample.includejsp.Util;
import ittimfn.sample.includejsp.model.InputModel;
import ittimfn.sample.includejsp.enums.FormEnum;

import ittimfn.sample.includejsp.datas.Datas;

@WebServlet("/insert")
public class InsertServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(InsertServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doPost called");

        InputModel model = createInputModel(request);
        logger.info("Inserting data: {}", model);

        Datas.addData(model);
        Common.getAndSetAttribute(request);

        response.sendRedirect(request.getContextPath() + "/");

    }

    private InputModel createInputModel(HttpServletRequest request) {
        InputModel model = new InputModel();
        model.setFormid(genId());
        model.setValue(Util.nullToEmpty(request.getParameter(FormEnum.value.name())));
        return model;
    }
    private String genId() {
        return String.valueOf(System.currentTimeMillis());
    }

}
