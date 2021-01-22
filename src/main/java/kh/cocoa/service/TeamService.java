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
}
