package ittimfn.sample.includejsp.models;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class PulldownOptionModel {
    private String value;
    private String displayString;
    private boolean isSelected;

    public String toOptionHtml() {
        StringBuilder builder = new StringBuilder();
        builder.append("<option value=\"")
            .append(value)
            .append("\"");
        if (isSelected) {
            builder.append(" selected");
        }
        builder.append(">")
            .append(displayString)
            .append("</option>");
        return builder.toString();
    }
}
