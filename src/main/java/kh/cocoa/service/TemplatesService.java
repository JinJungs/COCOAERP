package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.TemplatesDAO;

@Service
public class TemplatesService implements TemplatesDAO{
	
	@Autowired
	private TemplatesDAO tdao;
	
	
}
