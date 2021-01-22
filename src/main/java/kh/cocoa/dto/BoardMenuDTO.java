package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //lombok을 사용하기 때문에 getter/setter를 포함된것 
@NoArgsConstructor // 기본 생성자 역활 - DTO에 없는 경우
public class BoardMenuDTO {
	private int seq;
	private String name;
	private String type;
	
	@Builder
	public BoardMenuDTO(int seq, String name, String type) {
		super();
		this.seq = seq;
		this.name = name;
		this.type = type;
	}
	
	
}
