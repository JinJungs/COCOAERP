package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class MessengerViewDTO {
    private int seq;
    private String type;
    private String name;
    private int party_seq;
    private int emp_code;
    private String contents;
    private Timestamp write_date;
    //추가부분
    private String empname;
    private String deptname;
    private String teamname;
    private String posname;
    // 의진추가 - 프로필사진
    private String profile;

    @Builder
    public MessengerViewDTO(int seq, String type, String name, int party_seq, int emp_code, String contents, Timestamp write_date, String empname, String deptname, String teamname, String posname, String profile) {
        this.seq = seq;
        this.type = type;
        this.name = name;
        this.party_seq = party_seq;
        this.emp_code = emp_code;
        this.contents = contents;
        this.write_date = write_date;
        this.empname = empname;
        this.deptname = deptname;
        this.teamname = teamname;
        this.posname = posname;
        this.profile = profile;
    }
}
