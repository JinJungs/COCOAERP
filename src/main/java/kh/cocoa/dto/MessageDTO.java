package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
public class MessageDTO {
    private int seq;
    private String contents;
    private Date write_date;
    private int emp_code;
    private int msg_seq;

    @Builder
    public MessageDTO(int seq, String contents, Date write_date, int emp_code, int msg_seq) {
        this.seq = seq;
        this.contents = contents;
        this.write_date = write_date;
        this.emp_code = emp_code;
        this.msg_seq = msg_seq;
    }
}
