package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.ConfirmDTO;
import kh.cocoa.dto.EmployeeDTO;

@Mapper
public interface ConfirmDAO {

    public int addConfirm(int emp_code,int order, int doc_seq);
    
    public List<ConfirmDTO> getConfirmList(String seq);
    
    public String isConfirmed(String seq);

    public int deleteConfirm(int doc_seq);
    
    //업무일지 승인정보 불러오기
	public List<EmployeeDTO> confirmBy(int seq);
    
}
