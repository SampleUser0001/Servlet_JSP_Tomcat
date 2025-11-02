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

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(UpdateServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        String formid = request.getParameter("formid");
        InputModel model = Datas.getDataById(formid);

        // Set formMode to "update"
        request.setAttribute("formMode", "update");

        // Set form field values
        request.setAttribute(FormEnum.formid.name(), model.getFormid());
        request.setAttribute(FormEnum.value.name(), model.getValue());

        request.getRequestDispatcher("/WEB-INF/update.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doPost called");

        InputModel model = createInputModel(request);
        logger.info("Updating data: {}", model);

        Datas.updateData(model);

        response.sendRedirect(request.getContextPath() + "/");
    }

    private InputModel createInputModel(HttpServletRequest request) {
        InputModel model = new InputModel();
        model.setFormid(Util.nullToEmpty(request.getParameter(FormEnum.formid.name())));
        model.setValue(Util.nullToEmpty(request.getParameter(FormEnum.value.name())));
        return model;
    }

}
