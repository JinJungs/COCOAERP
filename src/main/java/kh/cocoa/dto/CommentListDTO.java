package kh.cocoa.dto;



import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //lombok을 사용하기 때문에 getter/setter를 포함된것 
@NoArgsConstructor // 기본 생성자 역활 - DTO에 없는 경우
public class CommentListDTO {
	private int seq;
	private String contents;
	private Date write_date;
	private int board_seq;
	private int writer_code;
	//추가된부분
	private String name;
	
	@Builder
	public CommentListDTO(int seq, String contents, Date write_date, int board_seq, int writer_code, String name) {
		super();
		this.seq = seq;
		this.contents = contents;
		this.write_date = write_date;
		this.board_seq = board_seq;
		this.writer_code = writer_code;
		this.name = name;
	}

	
}	
