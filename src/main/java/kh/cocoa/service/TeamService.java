package kh.cocoa.service;

import kh.cocoa.dao.TeamDAO;
import kh.cocoa.dto.TeamDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamService implements TeamDAO {

    @Autowired
    TeamDAO tdao;

    @Override
    public List<TeamDTO> getTeamList(int code){
        return tdao.getTeamList(code);
    }

    @Override
    public TeamDTO getTeamName(int code) {
        return tdao.getTeamName(code);
    }

    @Override
    public List<TeamDTO> getSearchTeamList(String name) {
        return tdao.getSearchTeamList(name);
    }

    @Override
    public List<TeamDTO> getSearchTeamCode(String name) {
        return tdao.getSearchTeamCode(name);
    }
    
    /* 소형 관리자 사용자관리*/
    @Override
    public List<TeamDTO> getAllTeamList(){
    	return tdao.getAllTeamList();
    };
    
    @Override
    public List<TeamDTO> getTeamListByDeptCode(int dept_code){
    	return tdao.getTeamListByDeptCode(dept_code);
    };
    
    @Override
    public int addTeam(List<TeamDTO> dto) {
    	return tdao.addTeam(dto);
    };
    
    @Override
    public int updateTeam(List<TeamDTO> dto) {
    	return tdao.updateTeam(dto);
    };
    
    @Override
    public int deleteTeam(List<TeamDTO> dto) {
    	return tdao.deleteTeam(dto);
    }
    
    @Override
    public int countNoTeam(int dept_code) {
    	return tdao.countNoTeam(dept_code);
    }
}
