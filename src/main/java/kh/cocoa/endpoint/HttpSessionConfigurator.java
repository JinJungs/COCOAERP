package kh.cocoa.endpoint;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

// ===================== HttpSessionConfigurator =====================
public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {

    public void modifyHandshake(ServerEndpointConfig sec,
                                HandshakeRequest request,
                                HandshakeResponse response) {
        // Handshake request와 response는 핸드셰이크과정에서  쓰이고 버려진다.
        // 그래서 이거는 onMessage까지 못온다.
        // request안에 session이 들어있더라도 우리가 사용하지를 못한다.
        // 그래서 이 안의 session을 미리 변수로 빼놓는다.
        // EndpointConfig는 언제든 다른매서드에서 매개변수로 추가가 가능하다.
        HttpSession session = (HttpSession)request.getHttpSession();
        sec.getUserProperties().put("hsession", session);
    }
}
