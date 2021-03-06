package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
public class AtdChangeReqDTO {

    private int seq;
    private String start_time;
    private String end_time;
    private String contents;
    private String status;
    private int atd_seq;
    private String today;
    private String atd_status;
    private int emp_code;
    private String name;
    private String comments;

    private int overtime;

    @Builder
    public AtdChangeReqDTO(int seq, String start_time, String end_time, String contents, String status, int atd_seq, String today, String atd_status, int emp_code, String name,String comments) {
        this.seq = seq;
        this.start_time = start_time;
        this.end_time = end_time;
        this.contents = contents;
        this.status = status;
        this.atd_seq = atd_seq;
        this.today = today;
        this.atd_status = atd_status;
        this.emp_code = emp_code;
        this.name = name;
        this.comments= comments;
    }
}
