package kh.cocoa.dto;

import java.sql.Date;
import java.util.List;

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
	private String report_contents;
	
	private String status;
	
	//추가부분
	private String temp_name;
	private String emp_name;
	private String dept_name;
	private String pos_name;
	private String detailStatus;

	private String con_empname;
	private String con_deptname;

	private int endNavi;
	private int startNavi;
	private boolean needPrev;
	private boolean needNext;
	private String name;

	@Builder
	public DocumentDTO(int seq, String title, String contents, Date write_date, Date final_date, int writer_code, int dept_code, int temp_code, String order_list, int order_count, String order_etc, Date leave_start, Date leave_end, String leave_type, Date report_start, Date report_end, String report_contents, String status, String temp_name, String emp_name, String dept_name, String con_empname, String con_deptname) {
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
		this.report_contents = report_contents;
		this.status = status;
		this.temp_name = temp_name;
		this.emp_name = emp_name;
		this.dept_name = dept_name;
		this.con_empname = con_empname;
		this.con_deptname = con_deptname;
	}
}
