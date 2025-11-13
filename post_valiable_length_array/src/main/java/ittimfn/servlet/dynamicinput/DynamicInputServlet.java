package ittimfn.servlet.dynamicinput;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/dynamicInput")
public class DynamicInputServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Logger logger = LogManager.getLogger(DynamicInputServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doGet called");
        // 初期表示
        request.getRequestDispatcher("/WEB-INF/dynamicInput.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.debug("doPost called");

        // 文字エンコーディングを設定
        request.setCharacterEncoding("UTF-8");

        // 配列でパラメータを取得（IDのみ）
        String[] itemIds = request.getParameterValues("itemIds");

        if (itemIds != null && itemIds.length > 0) {
            logger.info("受信したID件数: " + itemIds.length);
            for (int i = 0; i < itemIds.length; i++) {
                logger.info("ID[" + i + "]: " + itemIds[i]);
            }
            // 受信したデータをリクエスト属性に設定
            request.setAttribute("receivedItemIds", itemIds);
        } else {
            logger.warn("データが受信されませんでした");
        }

        // JSPにフォワード
        request.getRequestDispatcher("/WEB-INF/dynamicInput.jsp").forward(request, response);
    }
}
