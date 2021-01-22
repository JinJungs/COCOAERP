package kh.cocoa.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kh.cocoa.dao.CocoaWorksBoardDAO;
@Service
public class CocoaWorksBoardService implements CocoaWorksBoardDAO{
	@Autowired
	private CocoaWorksBoardDAO cdao;
}
