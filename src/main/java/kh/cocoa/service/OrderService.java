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
    public int addOrder(String order_list, int order_count, String order_etc, int doc_seq) {
        return odao.addOrder(order_list,order_count,order_etc,doc_seq);
    }
}
