package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
public class ConfirmDTO {

    private int seq;
    private int approver_code;
    private int approver_order;
    private String isConfirm;
    private Date confirm_date;
    private int doc_seq;
    private String comments;
    
    //추가부분
    private String emp_name;
    private String pos_name;
    private String dept_name;
    
    @Builder
	public ConfirmDTO(int seq, int approver_code, int approver_order, String isConfirm, Date confirm_date,
			int doc_seq, String comments) {
		super();
		this.seq = seq;
		this.approver_code = approver_code;
		this.approver_order = approver_order;
		this.isConfirm = isConfirm;
		this.confirm_date = confirm_date;
		this.doc_seq = doc_seq;
		this.comments = comments;
	}
}