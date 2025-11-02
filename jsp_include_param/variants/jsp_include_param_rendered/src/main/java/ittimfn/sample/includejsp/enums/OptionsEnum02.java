package ittimfn.sample.includejsp.enums;

import lombok.Getter;
import java.util.List;
import java.util.ArrayList;

import ittimfn.sample.includejsp.models.PulldownOptionModel;

@Getter
public enum OptionsEnum02 {
    OPTION_1(1, "02 Option 1"),
    OPTION_2(2, "02 Option 2"),
    OPTION_3(3, "02 Option 3");

    public static final String SELECT_ID = "sample02";

    private int value;
    private String label;

    private OptionsEnum02(int value, String label) {
        this.value = value;
        this.label = label;
    }

    public static List<PulldownOptionModel> createOptions(int selectedValue) {
        List<PulldownOptionModel> options = new ArrayList<>();
        for (OptionsEnum02 option : OptionsEnum02.values()) {
            boolean isSelected = option.getValue() == selectedValue;
            options.add(new PulldownOptionModel(String.valueOf(option.getValue()), option.getLabel(), isSelected));
        }
        return options;
    }

    public static OptionsEnum02 getDefault() {
        return OPTION_1;
    }

}
