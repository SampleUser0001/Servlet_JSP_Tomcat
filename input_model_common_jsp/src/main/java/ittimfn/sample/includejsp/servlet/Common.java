package ittimfn.sample.includejsp.servlet;

import javax.servlet.http.HttpServletRequest;

import ittimfn.sample.includejsp.Util;
import ittimfn.sample.includejsp.enums.FormEnum;

import ittimfn.sample.includejsp.enums.FormEnum;

public class Common {

    public static void getAndSetAttribute(HttpServletRequest request) {
        for (FormEnum formEnum : FormEnum.values()) {
            request.setAttribute(
                formEnum.name(),
                Util.nullToEmpty(request.getParameter(formEnum.name())));
        }
    }

    private Common() {
    }
}
