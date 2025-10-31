package ittimfn.sample.tomcat.pulldown;

import lombok.Getter;

@Getter
public enum OptionsEnum {
    OPTION_1(1, "Option 1"),
    OPTION_2(2, "Option 2"),
    OPTION_3(3, "Option 3");

    private int value;
    private String label;

    private OptionsEnum(int value, String label) {
        this.value = value;
        this.label = label;
    }

    public static OptionsEnum fromValue(int value) {
        for (OptionsEnum option : OptionsEnum.values()) {
            if (option.getValue() == value) {
                return option;
            }
        }
        return getDefault();
    }

    public static OptionsEnum fromValue(String label) {
        for (OptionsEnum option : OptionsEnum.values()) {
            if (String.valueOf(option.getValue()).equals(label)) {
                return option;
            }
        }
        return getDefault();
    }

    public static OptionsEnum getDefault() {
        return OPTION_2;
    }

    public static String getOptionsHTML(Object value) {
        StringBuilder html = new StringBuilder();
        for (OptionsEnum option : OptionsEnum.values()) {
            html.append("<option value='").append(option.getValue()).append("'");
            if (String.valueOf(option.getValue()).equals(String.valueOf(value))) {
                html.append(" selected");
            }
            html.append(">").append(option.getLabel()).append("</option>");
        }
        return html.toString();
    }
}
