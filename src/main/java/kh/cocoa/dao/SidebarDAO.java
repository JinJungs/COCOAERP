package kh.cocoa.dao;

import kh.cocoa.dto.SidebarViewDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SidebarDAO {
    public List<SidebarViewDTO> getSidebarList();
    public List<SidebarViewDTO> getBusinessLogList();
    public int businessLogCount();
    public int sidebarMenuCount();
    // menu_seq에 따른 리스트의 개수
    public int sidebarCountByMenuSeq(int menu_seq);
    // menu_seq에 따른 리스트
    public List<SidebarViewDTO> sidebarListByMenuSeq(int menu_seq);
}
