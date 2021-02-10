package kh.cocoa.service;

import kh.cocoa.dao.ConfirmDAO;
import kh.cocoa.dto.ConfirmDTO;
import kh.cocoa.dto.EmployeeDTO;

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
    
    @Override
    public String isConfirmed(String seq) {
    	return cdao.isConfirmed(seq);
    }

    @Override
    public int deleteConfirm(int doc_seq) {
        return cdao.deleteConfirm(doc_seq);
    }
    //업무일지 승인 정보 불러오기
    @Override
	public List<EmployeeDTO> confirmBy(int seq) {
		return cdao.confirmBy(seq);
	}
}
