package kh.cocoa.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageDTO {
    private int seq;
    private String contents;
    private Date write_date;
    private int emp_code;
    private int msg_seq;
}
