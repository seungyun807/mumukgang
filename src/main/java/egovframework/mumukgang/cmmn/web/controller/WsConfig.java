package egovframework.mumukgang.cmmn.web.controller;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.handler.invocation.HandlerMethodArgumentResolver;
import org.springframework.messaging.handler.invocation.HandlerMethodReturnValueHandler;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;

import egovframework.mumukgang.cmmn.web.ws.ChatWebSocketHandler;
import egovframework.mumukgang.cmmn.web.ws.EchoHandler;

//
//@Configuration
//@EnableWebSocketMessageBroker
//public class WsConfig implements WebSocketMessageBrokerConfigurer{
//    
//    @Override
//    public void configureMessageBroker(MessageBrokerRegistry config) {
//        config.enableSimpleBroker("/subscribe");
//        config.setApplicationDestinationPrefixes("/app");
//    }
//    
//    @Override
//    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        registry.addEndpoint("/endpoint").withSockJS();
//    }
//
//	@Override
//	public void configureWebSocketTransport(WebSocketTransportRegistration registry) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void configureClientInboundChannel(ChannelRegistration registration) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void configureClientOutboundChannel(ChannelRegistration registration) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void addReturnValueHandlers(List<HandlerMethodReturnValueHandler> returnValueHandlers) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public boolean configureMessageConverters(List<MessageConverter> messageConverters) {
//		// TODO Auto-generated method stub
//		return false;
//	}
//}



@Configuration
@EnableWebSocket
public class WsConfig implements WebSocketConfigurer {
	

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(echoHandler(), "/echo-ws");
		registry.addHandler(chatHandler(), "/chat-ws");
	}

	@Bean
	public EchoHandler echoHandler() {
		return new EchoHandler();
	}
	
	@Bean
	public ChatWebSocketHandler chatHandler() {
		return new ChatWebSocketHandler();
	}

}