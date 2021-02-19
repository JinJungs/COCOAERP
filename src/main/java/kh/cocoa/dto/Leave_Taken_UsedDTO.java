package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Leave_Taken_UsedDTO {
	private int seq;
	private int leave_got;
	private int leave_used;
	private int year;
	private int emp_code;
	
	//추가부분
	private int addLeave;
	private int code;
	
	@Builder
	public Leave_Taken_UsedDTO(int seq, int leave_got, int leave_used, int year, int emp_code, int addLeave, int code) {
		super();
		this.seq = seq;
		this.leave_got = leave_got;
		this.leave_used = leave_used;
		this.year = year;
		this.emp_code = emp_code;
		this.addLeave = addLeave;
		this.code = code;
	}
}
