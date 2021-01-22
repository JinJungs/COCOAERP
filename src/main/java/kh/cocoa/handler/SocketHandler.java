
package kh.cocoa.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kh.cocoa.dto.EmployeeDTO;

@Component
public class SocketHandler extends TextWebSocketHandler {

    //HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵
    List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        //메시지 발송
        String msg = message.getPayload();
        // 확인용
        System.out.println("msg : "+msg);
        JSONObject obj = JsonToObjectParser(msg);

        String rN = (String) obj.get("roomNumber");
        HashMap<String, Object> temp = new HashMap<String, Object>();
        if(rls.size() > 0) {
            for(int i=0; i<rls.size(); i++) {
                String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
                if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
                    temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                    break;
                }
            }

            //해당 방의 세션들만 찾아서 메시지를 발송해준다.
            for(String k : temp.keySet()) {
                if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
                    continue;
                }

                WebSocketSession wss = (WebSocketSession) temp.get(k);
                if(wss != null) {
                    try {
                        wss.sendMessage(new TextMessage(obj.toJSONString()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
    @SuppressWarnings("unchecked")
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //소켓 연결
        super.afterConnectionEstablished(session);
        boolean flag = false;
        String url = session.getUri().toString();
        System.out.println(url);
        String roomNumber = url.split("/chatting/")[1];
        //확인용3
        System.out.println("roomNumber : " + roomNumber);
        int idx = rls.size(); //방의 사이즈를 조사한다.
        //확인용4
        System.out.println("방사이즈 : " +idx);
        if(rls.size() > 0) {
            for(int i=0; i<rls.size(); i++) {
                String rN = (String) rls.get(i).get("roomNumber");
                if(rN.equals(roomNumber)) {
                    flag = true;
                    idx = i;
                    break;
                }
            }
        }

        if(flag) { //존재하는 방이라면 세션만 추가한다.
            HashMap<String, Object> map = rls.get(idx);
            map.put(session.getId(), session);
        }else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("roomNumber", roomNumber);
            map.put(session.getId(), session);
            rls.add(map);
        }

        //세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
        JSONObject obj = new JSONObject();
        obj.put("type", "getId");
        obj.put("sessionId", session.getId());
        session.sendMessage(new TextMessage(obj.toJSONString()));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        //소켓 종료
        if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
            for(int i=0; i<rls.size(); i++) {
                rls.get(i).remove(session.getId());
            }
        }
        super.afterConnectionClosed(session, status);
    }

    private static JSONObject JsonToObjectParser(String jsonStr) {
        JSONParser parser = new JSONParser();
        JSONObject obj = null;
        try {
            obj = (JSONObject) parser.parse(jsonStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return obj;
    }
    
    
    //파일 전송 
    //파일 전용 스태틱 : 나중에 스태틱 위치로 뺄 것===============================
  	private static final String FILE_UPLOAD_PATH = "C:\\files_cocoaERP\\";
  	static int fileUploadIdx = 0;
  	static String fileUploadSession = "";
  	//파일 전용 스태틱 : 나중에 스태틱 위치로 뺄 것===============================
    @Override
	public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
    	//세션 값 받기 전 임시 로그인 세션값
    	//EmployeeDTO loginDTO = EmployeeDTO.builder().code(1000).name("권용국").dept_code(1).team_code(11).deptname("개발부").teamname("개발1팀").build();

	      //String fileRoot = FILE_UPLOAD_PATH;
//	      String oriName = upload.getOriginalFilename(); 
//	      String extension = oriName.substring(oriName.lastIndexOf(".")); 
//	      oriName = new String(oriName.getBytes("8859_1"),"UTF8");
//	      String savedName = UUID.randomUUID() +extension;
//	      InputStream fileStream = upload.getInputStream();
//	      FilesDTO dto = new FilesDTO(0,oriName,savedName,null,users_id);
	    
	    //바이너리 메시지 발송
			ByteBuffer byteBuffer = message.getPayload();
			String fileName = "cute1.png";
			File dir = new File(FILE_UPLOAD_PATH);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			File file = new File(FILE_UPLOAD_PATH, fileName);
			FileOutputStream out = null;
			FileChannel outChannel = null;
			try {
				byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
				out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다.
				outChannel = out.getChannel(); //채널을 열고
				byteBuffer.compact(); //파일을 복사한다.
				outChannel.write(byteBuffer); //파일을 쓴다.
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(out != null) {
						out.close();
					}
					if(outChannel != null) {
						outChannel.close();
					}
				}catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			byteBuffer.position(0); //파일을 저장하면서 position값이 변경되었으므로 0으로 초기화한다.
			//파일쓰기가 끝나면 이미지를 발송한다.
			HashMap<String, Object> temp = rls.get(fileUploadIdx);
			for(String k : temp.keySet()) {
				if(k.equals("roomNumber")) {
					continue;
				}
				WebSocketSession wss = (WebSocketSession) temp.get(k);
				try {
					wss.sendMessage(new BinaryMessage(byteBuffer)); //초기화된 버퍼를 발송한다.
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
    }
}
