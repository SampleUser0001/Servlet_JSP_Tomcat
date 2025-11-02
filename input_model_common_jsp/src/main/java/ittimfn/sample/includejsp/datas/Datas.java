package ittimfn.sample.includejsp.datas;

import java.util.ArrayList;
import java.util.List;
import ittimfn.sample.includejsp.model.InputModel;

public interface Datas {
    public static final List<InputModel> DATA_LIST = new ArrayList<>();
    public static void addData(InputModel model) {
        DATA_LIST.add(model);
    }
    public static InputModel getDataById(String formid) {
        for (InputModel model : DATA_LIST) {
            if (model.getFormid().equals(formid)) {
                return model;
            }
        }
        return new InputModel("", "");
    }

}
