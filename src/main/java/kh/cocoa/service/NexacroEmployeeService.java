package kh.cocoa.service;

import java.sql.Date;

import org.springframework.stereotype.Service;
@Service
public class NexacroEmployeeService {

	public static String getRandomStr(int size) {
		if(size > 0) {
			char[] tmp = new char[size];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0이면 숫자로
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1이면 알파벳
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
			return new String(tmp);
		}
		return "ERROR : Size is required."; 
	}
	
	public Date getSqlDate(String date) {
		//스트링으로 받은 날짜를 SQL Date형으로 바꾸기
        String year = date.substring(0, 4);
        String month = date.substring(4, 6);
        String day = date.substring(6, 8);
        String full_date = year+"-"+month+"-"+day;
        java.sql.Date sqlDate =java.sql.Date.valueOf(full_date);
        return sqlDate;
	}
}
