package kh.cocoa.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentsDTO {

    private int code;
    private String name;
    private int location_code;
}
