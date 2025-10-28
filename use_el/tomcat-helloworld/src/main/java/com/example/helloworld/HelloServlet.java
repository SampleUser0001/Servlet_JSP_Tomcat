package com.example.helloworld;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HelloServlet", urlPatterns = "/hello")
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter(FormFieldId.NAME.getId());
        String trimmedName = name != null ? name.trim() : "";
        String greeting = null;
        if (!trimmedName.isEmpty()) {
            greeting = "サーブレットからのメッセージです。こんにちは、" + trimmedName + "さん。";
        }

        req.setAttribute("inputValue", trimmedName);
        req.setAttribute("greeting", greeting);
        req.getRequestDispatcher("/form.jsp").forward(req, resp);
    }
}
