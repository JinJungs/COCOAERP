package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.ConfirmDTO;

@Mapper
public interface ConfirmDAO {

    public int addConfirm(int emp_code,int order, int doc_seq);
    
    public List<ConfirmDTO> getConfirmList(String seq);
    
    public String isConfirmed(String seq);
    
}
