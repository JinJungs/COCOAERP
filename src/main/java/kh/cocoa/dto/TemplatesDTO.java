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
	private String explain;
	private String contents;
	private int temp_code;
	private int form_code;
	private int writer_code;
	
	@Builder
	public TemplatesDTO(int code, String name, String status, String explain, String contents, int temp_code, int form_code, int writer_code) {
		this.code = code;
		this.name = name;
		this.status = status;
		this.explain = explain;
		this.contents = contents;
		this.temp_code = temp_code;
		this.form_code = form_code;
		this.writer_code = writer_code;
	}
}

