package kh.cocoa.dto;


import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class TemplateFormDTO {
    private int code;
    private String title;
    private String contents;
    private String made_date;
    private String mod_date;
    private int emp_code;

    @Builder
    public TemplateFormDTO(int code, String title, String contents, String made_date, String mod_date, int emp_code) {
        this.code = code;
        this.title = title;
        this.contents = contents;
        this.made_date = made_date;
        this.mod_date = mod_date;
        this.emp_code = emp_code;
    }
}
