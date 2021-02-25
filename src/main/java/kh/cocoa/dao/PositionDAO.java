package kh.cocoa.dao;

import kh.cocoa.dto.PositionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PositionDAO {

	//소형 관리자 사용자관리
	public List<PositionDTO> getAllPosList();


	public List<PositionDTO> getPositionList();

	public int updatePosList(List<PositionDTO> list);
}

