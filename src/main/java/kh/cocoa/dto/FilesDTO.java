package kh.cocoa.dto;


import java.util.Date;


import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //lombok을 사용하기 때문에 getter/setter를 포함된것 
@NoArgsConstructor // 기본 생성자 역활 - DTO에 없는 경우
public class FilesDTO {
	private int seq;
	private String oriname;
	private String savedname;
	private Date uploadeddate;
	private int board_seq;
	private int document_seq;
<<<<<<< HEAD
	private int meg_seq;
	
	@Builder // 생성자가 id,nmae등 부분적으로 필요한것도 알아서 생성. 단, controller에서 해주어야할께 있음
	public FilesDTO(int seq, String oriname, String savedname, Date uploadeddate, int board_seq, int document_seq,
			int meg_seq) {
=======
	private int msg_seq;
	
	@Builder // 생성자가 id,nmae등 부분적으로 필요한것도 알아서 생성. 단, controller에서 해주어야할께 있음
	public FilesDTO(int seq, String oriname, String savedname, Date uploadeddate, int board_seq, int document_seq,
			int msg_seq) {
>>>>>>> 8f01702598d7b1a2f3337650b2dc1fd58886e8db
		super();
		this.seq = seq;
		this.oriname = oriname;
		this.savedname = savedname;
		this.uploadeddate = uploadeddate;
		this.board_seq = board_seq;
		this.document_seq = document_seq;
<<<<<<< HEAD
		this.meg_seq = meg_seq;
=======
		this.msg_seq = msg_seq;
>>>>>>> 8f01702598d7b1a2f3337650b2dc1fd58886e8db
	}
	
}
