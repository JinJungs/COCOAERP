package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SidebarViewDTO {
    private int code;
    private int mid_code;
    private String mid_name;
    private String sub_name;
    private int menu_seq;
    private String status;
    private String menu_name;

    @Builder
    public SidebarViewDTO(int code, int mid_code, String mid_name, String sub_name, int menu_seq, String status, String menu_name) {
        this.code = code;
        this.mid_code = mid_code;
        this.mid_name = mid_name;
        this.sub_name = sub_name;
        this.menu_seq = menu_seq;
        this.status = status;
        this.menu_name = menu_name;
    }
}
