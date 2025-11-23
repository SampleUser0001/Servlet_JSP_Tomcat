package ittimfn.sample.restapi.enums;

import ittimfn.sample.restapi.model.DataModel;
import lombok.Getter;

@Getter
public enum DataEnum {
    ITEM1(1, "Value1"),
    ITEM2(2, "Value2"),
    ITEM3(3, "Value3");

    private int id;
    private String value;

    private DataEnum(int id, String value) {
        this.id = id;
        this.value = value;
    }

    public static DataModel getData(int id) {
        for (DataEnum data : DataEnum.values()) {
            if (data.getId() == id) {
                DataModel model = new DataModel();
                model.setId(data.getId());
                model.setValue(data.getValue());
                return model;
            }
        }
        return null;
    }
}
