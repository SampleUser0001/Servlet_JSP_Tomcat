package ittimfn.sample.includejsp.enums;

import lombok.Getter;
import java.util.List;
import java.util.ArrayList;

@Getter
public enum OptionsEnum02 {
    OPTION_1(1, "02 Option 1"),
    OPTION_2(2, "02 Option 2"),
    OPTION_3(3, "02 Option 3");

    public static final String SELECT_ID = "sample02";
    public static final String KEY = "sample02";

    private int value;
    private String label;

    private OptionsEnum02(int value, String label) {
        this.value = value;
        this.label = label;
    }

    public static OptionsEnum02 getDefault() {
        return OPTION_1;
    }

    public static String genHTMLOption(Object selectedValue) {
        String _castedValue = (selectedValue != null) ? String.valueOf(selectedValue) : String.valueOf(getDefault().getValue());
        
        StringBuilder sb = new StringBuilder();
        for (OptionsEnum02 option : OptionsEnum02.values()) {
            sb.append("<option value=\"").append(option.getValue()).append("\"");
            if (String.valueOf(option.getValue()).equals(_castedValue)) {
                sb.append(" selected");
            }
            sb.append(">").append(option.getLabel()).append("</option>");
        }
        return sb.toString();
    }

}
