package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrganizationDTO {
	String org_nm;
	int org_cd;
	int p_org_cd;
	int level;
	
	@Builder
	public OrganizationDTO(String org_nm, int org_cd, int p_org_cd, int level) {
		super();
		this.org_nm = org_nm;
		this.org_cd = org_cd;
		this.p_org_cd = p_org_cd;
		this.level = level;
	}
}
