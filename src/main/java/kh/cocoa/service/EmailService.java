package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.EmailDAO;
import kh.cocoa.dto.EmailDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.statics.DocumentConfigurator;

@Service
public class EmailService implements EmailDAO{
	@Autowired
	private EmailDAO edao;
	
	@Override
	public void sendEmail(EmailDTO dto) {
		edao.sendEmail(dto);
	}
	@Override
	public int getSeq() {
		return edao.getSeq();
	}
	@Override
	public List<EmailDTO> sendToMeList(String email, int startRowNum, int endRowNum) {
		return edao.sendToMeList(email, startRowNum, endRowNum);
	}
	@Override
	public List<EmailDTO> receiveList(String email, int startRowNum, int endRowNum) {
		return edao.receiveList(email, startRowNum, endRowNum);
	}
	@Override
	public List<EmailDTO> sendList(String email, int startRowNum, int endRowNum) {
		return edao.sendList(email, startRowNum, endRowNum);
	}
	@Override
	public List<EmailDTO> deleteList(String email, int startRowNum, int endRowNum) {
		return edao.deleteList(email, startRowNum, endRowNum);
	}
	@Override
	public EmailDTO getEmail(String seq) {
		return edao.getEmail(seq);
	}
	
	@Override
	public int getToMeCount(String email) {
		return edao.getToMeCount(email);
	}
	@Override
	public int getReceiveCount(String email) {
		return edao.getReceiveCount(email);
	}
	@Override
	public int getSendCount(String email) {
		return edao.getSendCount(email);
	}
	@Override
	public int getDeleteCount(String email) {
		return edao.getDeleteCount(email);
	}
	public String getNavi(String email, String status, int cpage) {
		int recordTotalCount = 0;
		if(status.contentEquals("receive")) { //받은 메일함
			recordTotalCount = getReceiveCount(email);
		}else if(status.contentEquals("send")) {
			recordTotalCount = getSendCount(email);
		}else if(status.contentEquals("delete")) {
			recordTotalCount = getDeleteCount(email);
		}else if(status.contentEquals("sendToMe")) {
			recordTotalCount = getToMeCount(email);
		}
		
		int pageTotalCount = recordTotalCount / DocumentConfigurator.recordCountPerPage;
		if (recordTotalCount % DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage - 1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}
		
		StringBuilder sb = new StringBuilder();
		
		
		if(status.contentEquals("receive")) { 
			if (needPrev) {
				sb.append("<a href=/email/receiveList.email?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/email/receiveList.email?cpage=" + i + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/email/receiveList.email?cpage=" + (endNavi + 1) + ">   > </a>");
			}
		}else if(status.contentEquals("send")) {
			if (needPrev) {
				sb.append("<a href=/email/sendList.email?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/email/sendList.email?cpage=" + i + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/email/sendList.email?cpage=" + (endNavi + 1) + ">   > </a>");
			}
		}else if(status.contentEquals("delete")) {
			if (needPrev) {
				sb.append("<a href=/email/deleteList.email?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/email/deleteList.email?cpage=" + i + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/email/deleteList.email?cpage=" + (endNavi + 1) + ">   > </a>");
			}
		}else if(status.contentEquals("sendToMe")) {
			if (needPrev) {
				sb.append("<a href=/email/sendToMeList.email?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/email/sendToMeList.email?cpage=" + i + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/email/sendToMeList.email?cpage=" + (endNavi + 1) + ">   > </a>");
			}
		}
		return sb.toString();
	}
	
	@Override
	public void deleteToMeEmail(String seq) {
		edao.deleteToMeEmail(seq);
	}
	@Override
	public void deleteReceiveEmail(String seq) {
		edao.deleteReceiveEmail(seq);
	}
	@Override
	public void deleteSendEmail(String seq) {
		edao.deleteSendEmail(seq);
	}
	
	@Override
	public void deleteToMeNEmail(String seq) {
		edao.deleteToMeNEmail(seq);
	}
	@Override
	public void deleteReceiveNEmail(String seq) {
		edao.deleteReceiveNEmail(seq);
	}
	@Override
	public void deleteSendNEmail(String seq) {
		edao.deleteSendNEmail(seq);
	}
}
