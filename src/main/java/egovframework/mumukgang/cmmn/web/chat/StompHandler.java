package egovframework.mumukgang.cmmn.web.chat;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.util.Date;
import java.util.logging.Logger;

import javax.enterprise.inject.New;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.validation.Payload;
import javax.validation.Valid;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.core.MessageSendingOperations;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.broker.SimpleBrokerMessageHandler;
import org.springframework.messaging.simp.stomp.StompFrameHandler;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.support.ChannelInterceptorAdapter;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.client.WebSocketClient;

import egovframework.mumukgang.cmmn.web.chat.controller.ChatController;
import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
import lombok.RequiredArgsConstructor;
import net.sf.json.JSON;

@Component
public class StompHandler extends ChannelInterceptorAdapter {
	 
	@Autowired
	Messaging messaging;
	
	 
	@Override
    public void postSend(Message message, MessageChannel channel, boolean sent) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
        //Socket socket = new Socket("/enter/chat/9/endpoint", 80);
        String sessionId = accessor.getSessionId();
        switch (accessor.getCommand()) {
            case CONNECT:
            	System.out.println("StompHandler connect = " + sessionId);
            	
            	//Messaging messaging = Messaging();
            	messaging.checkNotice();
            	
                break;
            case DISCONNECT:
            	System.out.println("StompHandler disconnect");
                // 유저가 Websocket으로 disconnect() 를 한 뒤 호출됨 or 세션이 끊어졌을 때 발생함(페이지 이동~ 브라우저 닫기 등)
                break;
            default:
                break;
        }

    }
	
	private Socket socket;
	private BufferedReader br;
	private PrintWriter pw;
	
	public void Client1(String ip, int port) {
		try {
			// 서버에 요청 보내기
			socket = new Socket(ip, port);
			System.out.println(socket.getInetAddress().getHostAddress() + "에 연결됨");
			
			 DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
			 
			 DataInputStream dis = new DataInputStream(socket.getInputStream());
			// 메시지 받기
			//br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			//pw = new PrintWriter(socket.getOutputStream());
			
			// 메세지 전달
			//pw.println("메시지를 발송한다. 오버!");
			 String temp = "hi";
			 dos.writeUTF(temp);
			 //pw.flush();
			
			// 응답 출력
			System.out.println(br.readLine());
		} catch (IOException e) {
		    System.out.println(e.getMessage());
		} finally {
		    // 소켓 닫기 (연결 끊기)
		    try {
		    	if(socket != null) { socket.close(); }
		    } catch (IOException e) {
		        System.out.println(e.getMessage());
		    }
		}
	}
}