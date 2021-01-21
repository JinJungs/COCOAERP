package kh.cocoa.service;

import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.DocumentDAO;
import kh.cocoa.dto.DocumentDTO;

@Service
public class DocumentService implements DocumentDAO{
	
	@Autowired
	private DocumentDAO ddao;
	
	@Override
	public List<DocumentDTO> getTempList(){
		return ddao.getTempList();
	}


}
