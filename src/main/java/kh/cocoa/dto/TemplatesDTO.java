package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TemplatesDTO {
	private int code;
	private String name;
	private String status;
	
	@Builder
	public TemplatesDTO(int code, String name, String status) {
		super();
		this.code = code;
		this.name = name;
		this.status = status;
	}
}
