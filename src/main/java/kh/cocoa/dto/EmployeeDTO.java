package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
@NoArgsConstructor
public class EmployeeDTO{
    private int code;
    private String name;
    private String password;
    private String phone;
    private String office_phone;
    private String address;
    private String email;
    private String b_email;
    private String gender;
    private Date hire_date;
    private String withdraw;
    private int dept_code;
    private int pos_code;
    private int team_code;
    
    //추가부분
    private String deptname;
    private String teamname;
    private String posname;
    private int count;
    private String savedname;
    
    private int deptCode;
    private int teamCode;
    private int posCode;
    
    private int leave_got;
    private int leave_used;
    private int year;
    private int addLeave;
    
    @Builder
	public EmployeeDTO(int code, String name, String password, String phone, String office_phone, String address,
			String email, String b_email, String gender, Date hire_date, String withdraw, int dept_code, int pos_code,
			int team_code, String deptname, String teamname, String posname, int count, String savedname, int deptCode,
			int teamCode, int posCode, int leave_got, int leave_used, int year, int addLeave) {
		super();
		this.code = code;
		this.name = name;
		this.password = password;
		this.phone = phone;
		this.office_phone = office_phone;
		this.address = address;
		this.email = email;
		this.b_email = b_email;
		this.gender = gender;
		this.hire_date = hire_date;
		this.withdraw = withdraw;
		this.dept_code = dept_code;
		this.pos_code = pos_code;
		this.team_code = team_code;
		this.deptname = deptname;
		this.teamname = teamname;
		this.posname = posname;
		this.count = count;
		this.savedname = savedname;
		this.deptCode = deptCode;
		this.teamCode = teamCode;
		this.posCode = posCode;
		this.leave_got = leave_got;
		this.leave_used = leave_used;
		this.year = year;
		this.addLeave = addLeave;
	}
	
    
    
    
}