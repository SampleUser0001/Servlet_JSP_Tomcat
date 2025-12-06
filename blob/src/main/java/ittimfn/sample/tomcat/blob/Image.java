package ittimfn.sample.tomcat.blob;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Image {
    private int id;
    private String title;
    private String name;
    private String contentType;
    private byte[] imageData;
    private long fileSize;
    private Timestamp uploadedAt;
}
