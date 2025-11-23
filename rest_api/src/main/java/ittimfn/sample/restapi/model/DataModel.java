package ittimfn.sample.restapi.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.google.gson.Gson;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DataModel {
    private int id;
    private String value;

    public String getJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }
}
