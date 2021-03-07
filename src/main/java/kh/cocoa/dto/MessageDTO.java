package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class MessageDTO {
    private int seq;
    private String contents;
    private Timestamp write_date;
    private int emp_code;
    private int m_seq;
    //====추가======
    private String type;
    //====파일다운 위해 추가===
    private String savedname;
    // 사람 이름 추가
	private String empname;
	// 프로필 추가
    private String profile;
    // 채팅방 이름 추가 (연락처리스트에서 필요)
    private String roomname;
    
    @Builder
    public MessageDTO(int seq, String contents, Timestamp write_date, int emp_code, int m_seq, String type, String savedname, String empname, String profile, String roomname) {
        this.seq = seq;
        this.contents = contents;
        this.write_date = write_date;
        this.emp_code = emp_code;
        this.m_seq = m_seq;
        this.type = type;
        this.savedname = savedname;
        this.empname = empname;
        this.profile = profile;
        this.roomname = roomname;
    }
}