package com.example.helloworld;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(name = "HelloServlet", urlPatterns = "/hello")
public class HelloServlet extends HttpServlet {

    private static final Logger logger = LogManager.getLogger(HelloServlet.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        logger.info("HelloServlet#doGet");
        String name = req.getParameter(FormFieldId.NAME.getId());
        String trimmedName = name != null ? name.trim() : "";
        logger.debug("name: {}", trimmedName);
        String greeting = null;
        if (!trimmedName.isEmpty()) {
            greeting = "サーブレットからのメッセージです。こんにちは、" + trimmedName + "さん。";
        }

        req.setAttribute("inputValue", trimmedName);
        req.setAttribute("greeting", greeting);
        req.getRequestDispatcher("/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        logger.info("HelloServlet#doPost");
        String name = req.getParameter(FormFieldId.NAME.getId());
        String trimmedName = name != null ? name.trim() : "";
        String greeting = null;
        if (!trimmedName.isEmpty()) {
            greeting = "サーブレットからのメッセージです。こんにちは、" + trimmedName + "さん。";
        }
        logger.info("入力欄 name: {}", trimmedName);
        logger.info("特に入力欄もないが、JavaScriptで生成されて送信される値. send: {}", req.getParameter("send"));

        req.setAttribute("inputValue", trimmedName);
        req.setAttribute("greeting", greeting);
        req.getRequestDispatcher("/form.jsp").forward(req, resp);
    }
}
