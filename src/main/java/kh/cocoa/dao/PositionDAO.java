package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.PositionDTO;

@Mapper
public interface PositionDAO {

	//소형 관리자 사용자관리
	public List<PositionDTO> getAllPosList();


	public List<PositionDTO> getPositionList();
}

