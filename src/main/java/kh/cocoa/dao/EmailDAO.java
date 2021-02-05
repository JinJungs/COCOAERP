package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.EmailDTO;

@Mapper
public interface EmailDAO {

	public void sendEmail(EmailDTO dto);
	public int getSeq();
	
	public List<EmailDTO> receiveList(String email, int startRowNum, int endRowNum);
	public List<EmailDTO> sendList(String email, int startRowNum, int endRowNum);
	public List<EmailDTO> deleteList(String email, int startRowNum, int endRowNum);
	
	public EmailDTO getEmail(String seq);
	
	public int getReceiveCount(String email);
	public int getSendCount(String email);
	public int getDeleteCount(String email);
	
	public void deleteEmail(String seq);
	public void deleteNEmail(String seq);
}
