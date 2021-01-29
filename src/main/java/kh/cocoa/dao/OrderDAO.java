package kh.cocoa.dao;

import kh.cocoa.dto.OrderDTO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDAO {

    public int addOrder(String order_list, int order_count, String order_etc, int doc_seq);
    
    public List<OrderDTO> getOrderListBySeq(String seq);
}
