package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.PositionDAO;
import kh.cocoa.dto.PositionDTO;

@Service
public class PositionService implements PositionDAO{

	@Autowired
	private PositionDAO pdao;
	
	@Override
	public List<PositionDTO> getPositionList() {
		return pdao.getPositionList();
	}
}
