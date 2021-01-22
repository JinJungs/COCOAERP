package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TeamDTO {

    private int code;
    private String name;
    private int dept_code;

    @Builder
    public TeamDTO(int code, String name, int dept_code) {
        this.code = code;
        this.name = name;
        this.dept_code = dept_code;
    }
}
