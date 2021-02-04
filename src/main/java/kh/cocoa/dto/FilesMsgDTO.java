package kh.cocoa.dto;

import java.util.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
public class FilesMsgDTO {
	private int seq;
	private String oriname;
	private String savedname;
	private Date uploadeddate;
	private int msg_seq;
	private String type;
	private int m_seq;
	private String orinameEncoded;
	
	@Builder
	public FilesMsgDTO(int seq, String oriname, String savedname, Date uploadeddate, int msg_seq, String type,
			int m_seq, String orinameEncoded) {
		super();
		this.seq = seq;
		this.oriname = oriname;
		this.savedname = savedname;
		this.uploadeddate = uploadeddate;
		this.msg_seq = msg_seq;
		this.type = type;
		this.m_seq = m_seq;
		this.orinameEncoded = orinameEncoded;
	}
}
