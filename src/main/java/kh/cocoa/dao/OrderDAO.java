package kh.cocoa.dao;

import kh.cocoa.dto.OrderDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDAO {

    public int addOrder(OrderDTO dto,int doc_seq);
}
