package kh.cocoa.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TemplatesDTO {
    private int code;
    private String name;
    private String status;
}
