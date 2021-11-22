//package egovframework.mumukgang.cmmn.web.chat;
//
//import java.util.Date;
//
//import org.apache.logging.log4j.core.util.SystemClock;
//import org.aspectj.lang.annotation.Before;
//import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Configurable;
//import org.springframework.context.annotation.Bean;
//import org.springframework.messaging.converter.StringMessageConverter;
//import org.springframework.messaging.handler.annotation.SendTo;
//import org.springframework.messaging.simp.SimpMessagingTemplate;
//import org.springframework.messaging.simp.stomp.StompClientSupport;
//import org.springframework.messaging.MessageChannel;
//import org.springframework.stereotype.Component;
//import org.springframework.stereotype.Service;
//
//import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
//
//@Service
//public class Messaging {
//
//    private static final Logger logger = LoggerFactory.getLogger(Messaging.class);
//
//   
//    private SimpMessagingTemplate messagingTemplate; 
//
//    @Autowired
//    public  Messaging() {
//    	this.messagingTemplate = messagingTemplate;
//    }
//    
//    public void checkNotice(){
//        logger.info("checkNotice call");
//        try{
//        	Chat chat = new Chat();
//        	chat.setChatContent("hi");
//           // messagingTemplate.setMessageConverter(new StringMessageConverter());
//        	setTemplate(messagingTemplate);
//            this.messagingTemplate.convertAndSend("/subscribe/chat/11", chat);
//
//        }catch(Exception ex){
//            System.out.println(ex);
//        }
//    }
//}