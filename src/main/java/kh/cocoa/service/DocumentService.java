package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.DocumentDAO;
import kh.cocoa.dto.DocumentDTO;

@Service
public class DocumentService implements DocumentDAO{
	
	@Autowired
	private DocumentDAO ddao;
	//임시저장한 문서
	@Override
	public List<DocumentDTO> getTemporaryList() {
		return ddao.getTemporaryList();
	}
	@Override
	public List<DocumentDTO> getSearchTemporaryList() {
		return ddao.getSearchTemporaryList();
	}
	//상신한 문서
	@Override
	public List<DocumentDTO> getRaiseList() {
		return ddao.getRaiseList();
	}
	//승인된 문서
	@Override
	public List<DocumentDTO> getApprovalList() {
		return ddao.getApprovalList();
	}
	//반려된 문서
	@Override
	public List<DocumentDTO> getRejectList() {
		return ddao.getRejectList();
	}
	//회수한 문서
	@Override
	public List<DocumentDTO> getReturnList() {
		return ddao.getReturnList();
	}

}
