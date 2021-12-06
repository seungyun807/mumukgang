package egovframework.mumukgang.cmmn.web.chat;

import java.util.Collection;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.messaging.converter.CompositeMessageConverter;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.google.common.eventbus.Subscribe;

import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;


@Service
public class Messaging {

    private static final Logger logger = LoggerFactory.getLogger(Messaging.class);


//    @Autowired
// 	private SimpMessagingTemplate template;
// 	

 	Chat chat = new Chat();
 	
	@Subscribe
    public void checkNotice(SimpMessagingTemplate template){
        logger.info("checkNotice call");
        try{
        	chat.setChatContent("hi");
    		chat.setMemberId("김승윤");
    		
    		template.convertAndSend("/hello/24", chat);
    		template.convertAndSend("/app/hello/24", chat);
    		template.convertAndSend("/subscribe/chat/24", chat);
    		template.convertAndSend("subscribe/chat/24", chat);
    		template.convertAndSend("/subscribe/chat/24", "안녕");
    		template.convertAndSend("/test/24", chat);
    		template.convertAndSend("/subscribe/chat", chat);
        }catch(Exception ex){
            System.out.println(ex);
        }
    }
 	
 
}