package ittimfn.sample.tomcat.pulldown;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.sample.includejsp.models.PulldownModel;
import ittimfn.sample.includejsp.enums.OptionsEnum01;
import ittimfn.sample.includejsp.enums.OptionsEnum02;

@WebServlet("/")
public class IndexServlet extends HttpServlet {

    private Logger logger = LogManager.getLogger(IndexServlet.class);

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");

        setAttributes(request);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doPost called");

        Integer selected01 = getSelectedValue(OptionsEnum01.SELECT_ID, OptionsEnum01.getDefault().getValue(), request);
        Integer selected02 = getSelectedValue(OptionsEnum02.SELECT_ID, OptionsEnum02.getDefault().getValue(), request);

        logger.info("Selected values - Option 01: {}, Option 02: {}", selected01, selected02);

        setAttributes(request);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    private Integer getSelectedValue(String key, Integer defaultValue, HttpServletRequest request) {
        return Optional.ofNullable(request.getParameter(key))
            .map(Integer::valueOf)
            .orElse(defaultValue);
    }

    private void setAttributes(HttpServletRequest request) {
        setAttributesOptions01(request);
        setAttributesOptions02(request);
    }

    private void setAttributesOptions01(HttpServletRequest request) {
        Integer selectedValue = Optional.ofNullable(request.getParameter(OptionsEnum01.SELECT_ID))
            .map(Integer::valueOf)
            .orElse(OptionsEnum01.getDefault().getValue());

        PulldownModel sample01 = new PulldownModel(
            OptionsEnum01.SELECT_ID,
            OptionsEnum01.createOptions(selectedValue)
        );

        request.setAttribute(buildAttributeKey(OptionsEnum01.SELECT_ID), sample01);
    }

    private void setAttributesOptions02(HttpServletRequest request) {
        Integer selectedValue = Optional.ofNullable(request.getParameter(OptionsEnum02.SELECT_ID))
            .map(Integer::valueOf)
            .orElse(OptionsEnum02.getDefault().getValue());

        PulldownModel sample02 = new PulldownModel(
            OptionsEnum02.SELECT_ID,
            OptionsEnum02.createOptions(selectedValue)
        );

        request.setAttribute(buildAttributeKey(OptionsEnum02.SELECT_ID), sample02);
    }

    private String buildAttributeKey(String selectId) {
        return "pulldown." + selectId;
    }
}
