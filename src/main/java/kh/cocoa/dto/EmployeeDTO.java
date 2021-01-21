package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
public class EmployeeDTO {
	private int code;
	private String name;
	private String password;
	private String office_phone;
	private String address;
	private String email;
	private String b_email;
	private String gender;
	private Date hire_date;
	private String withdraw;
	private int team_code;
	private int dept_code;
	private int pos_code;
	
	@Builder
	public EmployeeDTO(int code, String name, String password, String office_phone, String address, String email,
			String b_email, String gender, Date hire_date, String withdraw, int team_code, int dept_code,
			int pos_code) {
		super();
		this.code = code;
		this.name = name;
		this.password = password;
		this.office_phone = office_phone;
		this.address = address;
		this.email = email;
		this.b_email = b_email;
		this.gender = gender;
		this.hire_date = hire_date;
		this.withdraw = withdraw;
		this.team_code = team_code;
		this.dept_code = dept_code;
		this.pos_code = pos_code;
	}	
}

