package egovframework.mumukgang.cmmn.web.chat;

import java.util.Date;

import org.apache.logging.log4j.core.util.SystemClock;
import org.aspectj.lang.annotation.Before;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompClientSupport;
import org.springframework.messaging.MessageChannel;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;

@Component
public class Messaging extends Thread {

    private static final Logger logger = LoggerFactory.getLogger(Messaging.class);

    private SimpMessagingTemplate messagingTemplate; 

    public void setMessagingTemplate(SimpMessagingTemplate messagingTemplate) {
    	this.messagingTemplate = messagingTemplate;
    }
    
    public void checkNotice(){
        logger.info("checkNotice call");
        try{
        	
            messagingTemplate.setMessageConverter(new StringMessageConverter());
            logger.info("hi");
            this.messagingTemplate.convertAndSend("/subscribe/chat/9", new Date().toString() + " : 이것은 서버 메시지이빈다.");

        }catch(Exception ex){
            System.out.println(ex);
        }
    }
}