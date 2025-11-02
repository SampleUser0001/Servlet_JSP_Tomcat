package ittimfn.sample.includejsp.enums;

import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


@Getter
public enum FormEnum {
    formid("ID", false, true, "readonly", "text"),
    value("Value",true, true, "", "text");

    private String label;
    private boolean isInit;
    private boolean isUpdate;
    private String readonly;
    private String type;

    private FormEnum(String label, boolean isInit, boolean isUpdate, String readonly, String type) {
        this.label = label;
        this.isInit = isInit;
        this.isUpdate = isUpdate;
        this.readonly = readonly;
        this.type = type;
    }

    public static List<FormEnum> getInitList() {
        return Stream.of(FormEnum.values())
            .filter(FormEnum::isInit)
            .collect(Collectors.toList());
    }

    public static List<FormEnum> getUpdateList() {
        return Stream.of(FormEnum.values())
            .filter(FormEnum::isUpdate)
            .collect(Collectors.toList());
    }
}
