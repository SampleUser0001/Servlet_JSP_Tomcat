package ittimfn.sample.tomcat.radio;

import java.util.Arrays;
import java.util.List;

/**
 * ラジオボタンの選択肢を定義する Enum。
 */
public enum OptionsEnum {

    CITY_TOKYO("tokyo", "東京"),
    CITY_OSAKA("osaka", "大阪"),
    CITY_SAPPORO("sapporo", "札幌"),
    CITY_FUKUOKA("fukuoka", "福岡");

    private final String value;
    private final String label;

    OptionsEnum(String value, String label) {
        this.value = value;
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public String getLabel() {
        return label;
    }

    public static OptionsEnum getDefault() {
        return CITY_TOKYO;
    }

    public static OptionsEnum fromValue(String value) {
        if (value == null) {
            return getDefault();
        }
        return Arrays.stream(values())
                .filter(option -> option.value.equalsIgnoreCase(value))
                .findFirst()
                .orElse(getDefault());
    }

    public static List<OptionsEnum> asList() {
        return Arrays.asList(values());
    }
}
