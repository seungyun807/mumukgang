//package egovframework.mumukgang.cmmn.web.chat;
//
//import java.util.List;
//import java.util.Map;
//
//import javax.security.auth.message.callback.PrivateKeyCallback.Request;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.event.EventListener;
//import org.springframework.messaging.Message;
//import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
//import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
//import org.springframework.messaging.support.GenericMessage;
//import org.springframework.messaging.support.MessageHeaderAccessor;
//import org.springframework.messaging.support.NativeMessageHeaderAccessor;
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.messaging.SessionConnectedEvent;
//import org.springframework.web.socket.messaging.SessionDisconnectEvent;
//
//@Component
//public class WebSocketEventListener {
//
//    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);
//
//    @Autowired
//    private Messaging chatService;
//    String sessionId;
//    @EventListener
//    public void handleWebSocketConnectListener(Message message, SessionConnectedEvent event) {
//      //  MessageHeaderAccessor accessor = NativeMessageHeaderAccessor.getAccessor(event.getMessage(), SimpMessageHeaderAccessor.class);
//    	StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
//        sessionId = accessor.getSessionId();
//    	Cookie cookie = new Cookie(sessionId, sessionId);
//    	System.out.println(cookie.getName());
//    	System.out.println(cookie.getValue());
//        /*StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
//        System.out.println("## headerAccessor :: " + headerAccessor);
//        String chatRoomId = headerAccessor.getNativeHeader("chatRoomId").get(0);
//        String sessionId = headerAccessor.getSessionId();*/
//
//
//    }
//
//    @EventListener
//    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
//        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
//
//        String sessionId = headerAccessor.getSessionId();
//
//        logger.info("[Disconnected] websocket session id : {}", sessionId);
//
//      chatService.checkNotice();
//    }
//}