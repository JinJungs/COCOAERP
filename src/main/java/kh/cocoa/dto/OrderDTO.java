package kh.cocoa.dto;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.core.annotation.Order;

import java.util.List;


@Data
@NoArgsConstructor
public class OrderDTO {

        private String order_list;
        private int order_count;
        private String order_etc;
        private int doc_seq;

        @Builder
        public OrderDTO(String order_list, int order_count, String order_etc, int doc_seq) {
                this.order_list = order_list;
                this.order_count = order_count;
                this.order_etc = order_etc;
                this.doc_seq = doc_seq;
        }
}
