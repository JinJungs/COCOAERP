package kh.cocoa.dto;

import java.sql.Timestamp;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ScheduleDTO {
	private String seq;
	private String title;
	private String contents;
	private Timestamp start_time;
	private Timestamp end_time;
	private String color;
	private String dept_code;
	private String team_code;
	private String emp_code;
	private String writer;

	//추가부분
	private String rownumber;
	private String str_start_time;
	private String str_end_time;
	
	@Builder
	public ScheduleDTO(String seq, String title, String contents, Timestamp start_time, Timestamp end_time,
			String color, String dept_code, String team_code, String emp_code, String writer, String rownumber, String str_start_time, String str_end_time) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.start_time = start_time;
		this.end_time = end_time;
		this.color = color;
		this.dept_code = dept_code;
		this.team_code = team_code;
		this.emp_code = emp_code;
		this.writer = writer;
		this.rownumber = rownumber;
		this.str_start_time = str_start_time;
		this.str_end_time = str_end_time;
	}
}