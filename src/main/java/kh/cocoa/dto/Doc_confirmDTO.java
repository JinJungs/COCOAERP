package kh.cocoa.dto;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Doc_confirmDTO {
   private int seq;
   private int approver_code;
   private int approver_order;
   private String isConfirm;
   private Date confirm_date;
   private String comments;
   private int doc_seq;
   
   @Builder
   public Doc_confirmDTO(int seq, int approver_code, int approver_order, String isConfirm, Date confirm_date, String comments, int doc_seq) {
      this.seq = seq;
      this.approver_code = approver_code;
      this.approver_order = approver_order;
      this.isConfirm = isConfirm;
      this.confirm_date = confirm_date;
      this.comments = comments;
      this.doc_seq = doc_seq;
   }
}