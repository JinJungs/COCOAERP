package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class EmailDTO {
	private int seq;
	private String title;
	private String contents;
	private Date write_date;
	private int parent;
	private String sender;
	private String receiver;
	private String status;
	
	//추가부분
	private String rownumber;
	private String write_dateString;
	
	@Builder
	public EmailDTO(int seq, String title, String contents, Date write_date, int parent, String sender, String receiver,
			String status) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.parent = parent;
		this.sender = sender;
		this.receiver = receiver;
		this.status = status;
	}
}
