package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
public class AtdChangeReqDTO {

    private int seq;
    private Date start_time;
    private Date end_time;
    private String contents;
    private String status;
    private int atd_seq;

    @Builder
    public AtdChangeReqDTO(int seq, Date start_time, Date end_time, String contents, String status, int atd_seq) {
        this.seq = seq;
        this.start_time = start_time;
        this.end_time = end_time;
        this.contents = contents;
        this.status = status;
        this.atd_seq = atd_seq;
    }
}
