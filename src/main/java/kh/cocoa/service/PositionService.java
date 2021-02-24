package kh.cocoa.service;

import kh.cocoa.dao.PositionDAO;
import kh.cocoa.dto.PositionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionService implements PositionDAO {
	
	
	@Autowired
	PositionDAO pdao;
	
//	소형 관리자 사용자관리
	@Override
	public List<PositionDTO> getAllPosList(){
		return pdao.getAllPosList(); 
	}
	
	@Override
	public List<PositionDTO> getPositionList() {
		return pdao.getPositionList();
	}

	@Override
	public int updatePosList(List<PositionDTO> list){ return pdao.updatePosList(list); }
}
