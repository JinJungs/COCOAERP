package kh.cocoa.dao;

import kh.cocoa.dto.SidebarViewDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SidebarDAO {
    public int sidebarMenuCount();
    // menu_seq에 따른 리스트의 개수
    public int sidebarCountByMenuSeq(int menu_seq);
    // menu_seq에 따른 리스트
    public List<SidebarViewDTO> sidebarListByMenuSeq(int menu_seq);
    //커뮤니티 추가
	public int addSideBar(String name,int board_menu_seq);

	//게시글 이름& 타입 가져오기
	public SidebarViewDTO selectInfor(int menu_seq);

	public int uptSideBar(String name, int seq);
	public int delBoard(int seq);

    // ---- 넥사크로 ----
    // 사이드바 전체리스트 가져오기
    public List<SidebarViewDTO> getSidebarList();
    // 사이드바 update - dto 한개만
    public int updateSidebar(SidebarViewDTO sdto);
    // 사이드바 update - list 로
    public int updateSidebarAll(List<SidebarViewDTO> list);
}
