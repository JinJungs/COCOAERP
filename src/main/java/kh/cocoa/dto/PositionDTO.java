package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PositionDTO {
	private int code;
	private String name;
	
	@Builder
	public PositionDTO(int code, String name) {
		super();
		this.code = code;
		this.name = name;
	}
}
