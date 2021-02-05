package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class AttendanceDTO {
    private int seq;
    private Timestamp start_time;
    private Timestamp end_time;
    private String status;
    private int emp_code;

    @Builder
    public AttendanceDTO(int seq, Timestamp start_time, Timestamp end_time, String status, int emp_code) {
        this.seq = seq;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;
        this.emp_code = emp_code;
    }
}
