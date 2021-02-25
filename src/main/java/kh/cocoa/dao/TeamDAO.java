package kh.cocoa.dao;

import kh.cocoa.dto.TeamDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TeamDAO {

    public List<TeamDTO> getTeamList(int code);
    public TeamDTO getTeamName(int code);
    public List<TeamDTO> getSearchTeamList(String name);
    public List<TeamDTO> getSearchTeamCode(String name);
    /* 소형 관리자 사용자관리*/
    public List<TeamDTO> getAllTeamList();
    public List<TeamDTO> getTeamListByDeptCode(int dept_code);
}
