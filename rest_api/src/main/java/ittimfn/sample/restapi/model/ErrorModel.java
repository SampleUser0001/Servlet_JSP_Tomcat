package ittimfn.sample.restapi.model;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ErrorModel {
    private String message;

    public String toJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }
}