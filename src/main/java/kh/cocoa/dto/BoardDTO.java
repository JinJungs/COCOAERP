package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardDTO {
	private int seq;
	private String title;
	private String contents;
	private Date write_date;
	private int view_count;
	private int writer_code;
	private int menu_seq;
	/* 추가부분 */
	private String name;
	private String savedname;
	
	@Builder
	public BoardDTO(int seq, String title, String contents, Date write_date, int view_count, int writer_code,
			int menu_seq,String name,String savedname) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.writer_code = writer_code;
		this.menu_seq = menu_seq;
		this.name = name;
		this.savedname=savedname;
	}

}
