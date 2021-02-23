package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NexacroSearchDTO {
	int dept_code;
	int team_code;
	int pos_code;
	String search;
	String searchWhat;
	
	@Builder
	public NexacroSearchDTO(int dept_code, int team_code, int pos_code, String search, String searchWhat) {
		super();
		this.dept_code = dept_code;
		this.team_code = team_code;
		this.pos_code = pos_code;
		this.search = search;
		this.searchWhat = searchWhat;
	}
}
