package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MessengerDTO {
    private int seq;
    private int emp_code;
    private int emp_code2;

    @Builder
    public MessengerDTO(int seq, int emp_code, int emp_code2) {
        this.seq = seq;
        this.emp_code = emp_code;
        this.emp_code2 = emp_code2;
    }
}
