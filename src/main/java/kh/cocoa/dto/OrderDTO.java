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
        private String order_count;
        private String order_etc;
        private List<OrderDTO> list;


        @Builder
        public OrderDTO( String order_list, String order_count, String order_etc) {
                this.order_list = order_list;
                this.order_count = order_count;
                this.order_etc = order_etc;
        }

}
