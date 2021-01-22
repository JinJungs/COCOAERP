package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.AlbumBoardDAO;

@Service
public class AlbumBoardService implements AlbumBoardDAO {
	@Autowired
	private AlbumBoardDAO adao;
}
