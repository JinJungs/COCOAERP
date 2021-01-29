
package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MessengerDTO {
	private int seq;
	private String type;
	private String name;
	@Builder
	public MessengerDTO(int seq, String type, String name) {
		this.seq = seq;
		this.type = type;
		this.name = name;
	}
}
