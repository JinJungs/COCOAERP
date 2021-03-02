package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class AttendanceDTO {
    private int seq;
    private Timestamp start_time;
    private Timestamp end_time;
    private String status;
    private int emp_code;
    private int overtime;

    //임의로 추가
    private String sub_start_time;
    private String sub_end_time;
    private String today;
    private String req_status;

    @Builder
    public AttendanceDTO(int seq, Timestamp start_time, Timestamp end_time, String status, int emp_code, int overtime, String sub_start_time, String sub_end_time, String today, String req_status) {
        this.seq = seq;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;
        this.emp_code = emp_code;
        this.overtime = overtime;
        this.sub_start_time = sub_start_time;
        this.sub_end_time = sub_end_time;
        this.today = today;
        this.req_status = req_status;
    }
}
