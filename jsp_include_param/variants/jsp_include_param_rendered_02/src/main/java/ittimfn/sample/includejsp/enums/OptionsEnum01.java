package ittimfn.sample.includejsp.enums;

import lombok.Getter;
import java.util.List;
import java.util.ArrayList;

import ittimfn.sample.includejsp.models.PulldownOptionModel;

@Getter
public enum OptionsEnum01 {
    OPTION_1(1, "Option 1"),
    OPTION_2(2, "Option 2"),
    OPTION_3(3, "Option 3");

    public static final String SELECT_ID = "sample01";
    public static final String KEY = "sample01";

    private int value;
    private String label;

    private OptionsEnum01(int value, String label) {
        this.value = value;
        this.label = label;
    }

    public static List<PulldownOptionModel> createOptions(int selectedValue) {
        List<PulldownOptionModel> options = new ArrayList<>();
        for (OptionsEnum01 option : OptionsEnum01.values()) {
            boolean isSelected = option.getValue() == selectedValue;
            options.add(new PulldownOptionModel(String.valueOf(option.getValue()), option.getLabel(), isSelected));
        }
        return options;
    }

    public static OptionsEnum01 getDefault() {
        return OPTION_2;
    }

    public static String genHTMLOption(Object selectedValue) {
        String _castedValue = (selectedValue != null) ? String.valueOf(selectedValue) : String.valueOf(getDefault().getValue());
        
        StringBuilder sb = new StringBuilder();
        for (OptionsEnum01 option : OptionsEnum01.values()) {
            sb.append("<option value=\"").append(option.getValue()).append("\"");
            if (String.valueOf(option.getValue()).equals(_castedValue)) {
                sb.append(" selected");
            }
            sb.append(">").append(option.getLabel()).append("</option>");
        }
        return sb.toString();
    }

}
