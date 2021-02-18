package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
public class NexacroFakeEmployeeDTO {
    private int code;
    private String name;
    private String password;
    private String phone;
    private String office_phone;
    private String address;
    private String email;
    private String b_email;
    private String gender;
    private String hire_date;
    private String withdraw;
    private int dept_code;
    private int pos_code;
    private int team_code;
    
    @Builder
	public NexacroFakeEmployeeDTO(int code, String name, String password, String phone, String office_phone,
			String address, String email, String b_email, String gender, String hire_date, String withdraw,
			int dept_code, int pos_code, int team_code) {
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
	}   
}
