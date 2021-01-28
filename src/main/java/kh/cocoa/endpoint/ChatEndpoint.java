package kh.cocoa.endpoint;

// httpSession과 상관없는 socket에 있는 session이다.

import lombok.extern.java.Log;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.*;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// Spring과 전혀 관계없다.
// Spring의 관리대상이 아니기 때문에 Autowired를 쓰지 못한다.
// client의 채팅을 받아주는 함수이다.
// HandShaking 하는 설정을 우리가 configurator로 지정해주는 것이다.
@Log
@Component
@ServerEndpoint(value = "/websocket", configurator = HttpSessionConfigurator.class)
public class ChatEndpoint {

    BufferedOutputStream bos;
    String path = "C:\\files_cocoaERP\\";
    // 세션정보를 보관해야한다.
    // Set : List 와 유사한 Collection 으로 데이터를 무한히 저장할 수 있지만 중복을 허용하지 않음.
    // 동시성 오류를 잡기위해서 사용한다.
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    // 사용자가 접속했을 때 실행되는 메서드
    // ArrayList에 접속한 사람들을 담는다.
    @OnOpen
    public void onConnect(Session client, EndpointConfig con) {
        System.out.println(client.getId() + " 클라이언트가 접속했습니다.");
        clients.add(client);
        HttpSession hsession = (HttpSession) con.getUserProperties().get("hsession");
        String id = (String) hsession.getAttribute("loginInfo");
        System.out.println(id);
    }

    // 메세지를 받았을 때
    @OnMessage
    public void onMessage(String msg, Session session) {
        System.out.println("도착여부 : " + msg);
        // throws Exception처리를 하면 for문이 끝나게 되므로 try-catch
        // 받은 메세지를 접속한모든 client들에게 메세지를 뿌려줘야하므로 for문을 돌린다.

        // Configurator에서 EndpointConfig에 담아뒀던 httpSession을 얻어온다.
        // Spring에서 쓰고 있는 httpSession과 같기 때문에 우리는 이제 쓸 수 있다.
        //HttpSession hsession = (HttpSession)con.getUserProperties().get("hsession");
        //String id = (String)hsession.getAttribute("loginInfo");

        synchronized (clients) {
            for (Session client : clients) {
                try {
                    if (session != client) {
                        client.getBasicRemote().sendText(msg);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 클라이언트에서 파일이 끝났다는 신호로 "end" 문자열을 보낸다.
        // msg가 end가 아니라면 파일로 연결된 스트림을 연다.
        if (!msg.equals("end")) {

            // 클라이언트에서 파일을 전송하기전 파일이름을 "file name:aaa.aaa" 형식으로 보낸다.
            String fileName = msg.substring(msg.indexOf(":") + 1);
            System.out.println(fileName);
            File file = new File(path + fileName);
            try {
                bos = new BufferedOutputStream(new FileOutputStream(file));
            } catch (FileNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // msg 가 end가 왔다면 전송이 완료되었음을 알리는 신호이므로 outputstream 을 닫아준다.
        } else {
            try {
                bos.flush();
                bos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

/*    @OnMessage
    public void onMessage(Session session, String msg) throws IOException {
        // 클라이언트에서 fileName:파일명 형태로 파일 요청
        String fileName = msg.substring(msg.indexOf(":") + 1);
        System.out.println("request file : " + fileName); // 파일 객체 생성
        File file = new File(path + fileName); // 파일을 담을 바이트 배열
        byte[] fileBytes = new byte[(int) file.length()];
        try ( // 파일로 연결된 스트림 생성
              BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));) { // 바이트 배열에 파일 저장
            bis.read(fileBytes); } // ByteBuffer에 바이트 배열을 담는다
        ByteBuffer buf = ByteBuffer.wrap(fileBytes); // ByteBuffer 를 클라이언트로 보낸다.
        session.getBasicRemote().sendBinary(buf);
        }*/

        // 바이너리 데이터가 오게되면 호출된다.
        @OnMessage
        public void processUpload (ByteBuffer msg,boolean last, Session session){
            System.out.println("파일 onMessage 도착!");
            while (msg.hasRemaining()) {
                try {
                    bos.write(msg.get());
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }

        // 연결이 끊어졌을때
        @OnClose
        public void donDisconnect (Session session){
            clients.remove(session);
        }

    }
