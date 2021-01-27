package kh.cocoa.service;

import kh.cocoa.dao.ConfirmDAO;
import kh.cocoa.dto.ConfirmDTO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfirmService implements ConfirmDAO {

    @Autowired
    private ConfirmDAO cdao;

    @Override
    public int addConfirm(int emp_code, int order, int doc_seq) {
        return cdao.addConfirm(emp_code,order,doc_seq);
    }
    
    @Override
    public List<ConfirmDTO> getConfirmList(String seq) {
    	return cdao.getConfirmList(seq);
    }
}
