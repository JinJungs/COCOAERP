package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LeaveDTO {
	private int seq;
	private String type;
	private Date start_date;
	private Date end_date;
	private int time;
	private int emp_code;
	
	//추가부분
	private int rownumber;
	private int duration;
	
	@Builder
	public LeaveDTO(int seq, String type, Date start_date, Date end_date, int time, int emp_code, int rownumber,
			int duration) {
		super();
		this.seq = seq;
		this.type = type;
		this.start_date = start_date;
		this.end_date = end_date;
		this.time = time;
		this.emp_code = emp_code;
		this.rownumber = rownumber;
		this.duration = duration;
	}
}
