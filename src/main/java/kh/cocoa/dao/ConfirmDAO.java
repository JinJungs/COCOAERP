package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ConfirmDAO {

    public int addConfirm(int emp_code,int order, int doc_seq);
}
