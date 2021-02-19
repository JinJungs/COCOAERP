package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.PositionDTO;

@Mapper
public interface PositionDAO {
	public List<PositionDTO> getPositionList();
}