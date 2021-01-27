package kh.cocoa.service;

import kh.cocoa.dao.OrderDAO;
import kh.cocoa.dto.OrderDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService implements OrderDAO {

    @Autowired
    private OrderDAO odao;

    @Override
    public int addOrder(OrderDTO dto,int doc_seq) {
        return odao.addOrder(dto,doc_seq);
    }
}
