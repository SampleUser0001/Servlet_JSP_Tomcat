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
}
