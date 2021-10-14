//package egovframework.mumukgang.cmmn.web;
//
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.Map;
//
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//public class MyWebSocketHandler extends TextWebSocketHandler {
//	
//	private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();
//	@Override
//	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
//		System.out.println("세션아이디[" + session.getId() +"] 입장.");
//		
//		Iterator<String> sessionIds = sessions.keySet().iterator();
//		
//		String sessionId = "";
//		while(sessionIds.hasNext()) {
//			sessionId = sessionIds.next();
//			sessions.get(sessionId).sendMessage(new TextMessage("[" + session.getId() + "] 입장."));
//		}
//		
//		sessions.put(session.getId(), session);
//	}
//	
//	@Override
//	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
//		System.out.println("세션아이디[" + session.getId() +"] 퇴장.");
//		
//		sessions.remove(session.getId());
//		
//		Iterator<String> sessionIds = sessions.keySet().iterator();
//		
//		String sessionId="";
//		while(sessionIds.hasNext()) {
//			sessionId = sessionIds.next();
//			sessions.get(sessionId).sendMessage(new TextMessage("[" + session.getId() + "] 퇴장."));
//		}
//	}
//	
//	@Override
//	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
//		System.out.println(session.getId() +"이(가) 메세지전송.");
//		
//		Iterator<String> sessionIds = sessions.keySet().iterator();
//		String sessionId = "";
//		while(sessionIds.hasNext()) {
//			sessionId = sessionIds.next();
//			sessions.get(sessionId).sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
//		}
//		
//	}
//}