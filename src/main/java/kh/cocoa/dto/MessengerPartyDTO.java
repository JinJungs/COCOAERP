package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MessengerPartyDTO {
    private int seq;
    private int m_seq;
    private int emp_code;

    @Builder
    public MessengerPartyDTO(int seq, int m_seq, int emp_code) {
        this.seq = seq;
        this.m_seq = m_seq;
        this.emp_code = emp_code;
    }
}
