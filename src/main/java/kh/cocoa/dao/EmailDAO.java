package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.EmailDTO;

@Mapper
public interface EmailDAO {

	public void sendEmail(EmailDTO dto);
	public int getSeq();
	
	public List<EmailDTO> sendToMeList(String email, int startRowNum, int endRowNum);
	public List<EmailDTO> receiveList(String email, int startRowNum, int endRowNum);
	public List<EmailDTO> sendList(String email, int startRowNum, int endRowNum);
	public List<EmailDTO> deleteList(String email, int startRowNum, int endRowNum);
	
	public EmailDTO getEmail(String seq);
	
	public int getToMeCount(String email);
	public int getReceiveCount(String email);
	public int getSendCount(String email);
	public int getDeleteCount(String email);
	
	public void deleteToMeEmail(String seq);
	public void deleteReceiveEmail(String seq);
	public void deleteSendEmail(String seq);
	
	
	public void deleteToMeNEmail(String seq);
	public void deleteReceiveNEmail(String seq);
	public void deleteSendNEmail(String seq);
}
