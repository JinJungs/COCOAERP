package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.EmailDTO;

@Mapper
public interface EmailDAO {

	public void sendEmail(EmailDTO dto);
}
