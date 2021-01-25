package kh.cocoa.handler;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component
class BinarySocketHandler extends BinaryWebSocketHandler {

    List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions

    //파일 전송
    //파일 전용 스태틱 : 나중에 스태틱 위치로 뺄 것===============================
    private static final String FILE_UPLOAD_PATH = "C:\\files_cocoaERP\\";
    static int fileUploadIdx = 0;
    static String fileUploadSession = "";
    //파일 전용 스태틱 : 나중에 스태틱 위치로 뺄 것===============================

    @SuppressWarnings("unchecked")
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("afterConnectionEstablished 도착!!");
        super.afterConnectionEstablished(session);

    }
    @Override
    public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
        System.out.println("여기에 도착!! binary!");
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

}
