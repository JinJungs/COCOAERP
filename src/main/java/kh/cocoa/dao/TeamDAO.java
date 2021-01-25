package kh.cocoa.dao;

import kh.cocoa.dto.TeamDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TeamDAO {

    public List<TeamDTO> getTeamList(int code);
}