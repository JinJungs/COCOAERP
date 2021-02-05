package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class MessageViewDTO {
    // message
    private int seq;
    private String contents;
    private Timestamp write_date;
    private int emp_code;
    private int m_seq;
    private String type;
    // messenger
    private String m_type;
    private String name;
    // messenger_party
    private int party_seq;
    private int party_emp_code;
    //employee
    private String empname;
    private String party_empname;

    @Builder
    public MessageViewDTO(int seq, String contents, Timestamp write_date, int emp_code, int m_seq, String type, String m_type, String name, int party_seq, int party_emp_code, String empname, String party_empname) {
        this.seq = seq;
        this.contents = contents;
        this.write_date = write_date;
        this.emp_code = emp_code;
        this.m_seq = m_seq;
        this.type = type;
        this.m_type = m_type;
        this.name = name;
        this.party_seq = party_seq;
        this.party_emp_code = party_emp_code;
        this.empname = empname;
        this.party_empname = party_empname;
    }
}
