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
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.broker.SimpleBrokerMessageHandler;
import org.springframework.messaging.simp.stomp.StompFrameHandler;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.support.ChannelInterceptorAdapter;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.client.WebSocketClient;

import egovframework.mumukgang.cmmn.web.chat.controller.ChatController;
import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
import lombok.RequiredArgsConstructor;
import net.sf.json.JSON;

@Service
@Component
public class StompHandler extends ChannelInterceptorAdapter {


	 	private final SimpMessagingTemplate template;

	
	 	@Autowired
	    public StompHandler (SimpMessagingTemplate template) {
	        this.template = template;
	    }
	 	
		 Chat chat = new Chat();
		 
		@Override
		public void postSend(Message message, MessageChannel channel, boolean sent) {
			StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
			//Socket socket = new Socket("/enter/chat/9/endpoint", 80);
			String sessionId = accessor.getSessionId();
			switch (accessor.getCommand()) {
            	case CONNECT:
            		System.out.println("StompHandler connect = " + sessionId);
            		
            		//setTemplate(template);
            		chat.setChatContent("hi");
            		this.template.convertAndSend("/subscribe/chat/24", chat);
            		
            		
            		break;
            	case DISCONNECT:
            		System.out.println("StompHandler disconnect");
            		// 유저가 Websocket으로 disconnect() 를 한 뒤 호출됨 or 세션이 끊어졌을 때 발생함(페이지 이동~ 브라우저 닫기 등)
            	//	setTemplate(template);
           
//            		chat.setChatContent("bye");
//           	
//            		this.template.convertAndSend("/subscribe/chat/9", chat);
           	
            		break;
            	default:
            		break;
        }

    }
	
}