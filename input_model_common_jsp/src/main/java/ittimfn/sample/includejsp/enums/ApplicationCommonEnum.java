package ittimfn.sample.includejsp.enums;

import lombok.Getter;

@Getter
public enum ApplicationCommonEnum {
    APPLICATION_TITLE("application.title", "Include JSP Sample Application"),
    PULLDOWN_KEY("pulldown.key", "");

    private String code;
    private String defaultValue;

    private ApplicationCommonEnum(String code, String defaultValue) {
        this.code = code;
        this.defaultValue = defaultValue;
    }
}
