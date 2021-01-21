package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

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
    private String deptname;
    private String teamname;

    @Builder
    public EmployeeDTO(int code, String name, String password, String office_phone, String address, String email, String b_email, String gender, Date hire_date, String withdraw, String deptname, String teamname) {
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
        this.deptname = deptname;
        this.teamname = teamname;
    }
}