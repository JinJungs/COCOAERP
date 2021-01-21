package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DocumentDTO {
	private int seq;
	private String title;
	private String contents;
	private Date write_date;
	private Date final_date;
	private int writer_code;
	private int dept_code;
	private int temp_code;
	
	private String order_list;
	private int order_count;
	private String order_etc;
	
	private Date leave_start;
	private Date leave_end;
	private String leave_type;
	
	private Date report_start;
	private Date report_end;
	private String report_issue;
	
	private String status;
	
	//추가부분
	private String temp_name;
	private String emp_name;
	private String department_name;
	

	@Builder
	public DocumentDTO(int seq, String title, String contents, Date write_date, Date final_date, int writer_code,
			int dept_code, int temp_code, String order_list, int order_count, String order_etc, Date leave_start,
			Date leave_end, String leave_type, Date report_start, Date report_end, String report_issue, String status) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.final_date = final_date;
		this.writer_code = writer_code;
		this.dept_code = dept_code;
		this.temp_code = temp_code;
		this.order_list = order_list;
		this.order_count = order_count;
		this.order_etc = order_etc;
		this.leave_start = leave_start;
		this.leave_end = leave_end;
		this.leave_type = leave_type;
		this.report_start = report_start;
		this.report_end = report_end;
		this.report_issue = report_issue;
		this.status = status;
	}
}
