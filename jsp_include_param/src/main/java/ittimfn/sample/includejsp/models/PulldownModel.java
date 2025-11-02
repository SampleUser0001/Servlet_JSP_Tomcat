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
}