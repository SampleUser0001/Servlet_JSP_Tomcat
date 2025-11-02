package ittimfn.sample.includejsp.models;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class PulldownModel {
    private String id;
    private List<PulldownOptionModel> options;

    public String buildOptionsHtml() {
        if (options == null) {
            return "";
        }
        StringBuilder builder = new StringBuilder();
        for (PulldownOptionModel option : options) {
            builder.append(option.toOptionHtml());
        }
        return builder.toString();
    }
}
