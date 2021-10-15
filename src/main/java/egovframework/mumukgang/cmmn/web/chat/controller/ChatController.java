package egovframework.mumukgang.cmmn.web.chat.controller;



import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
	@MessageMapping("/hello/{roomNo}")
	@SendTo("/subscribe/chat/{roomNo}")
	public Chat broadcasting(Chat chat) {
		chat.setSendDate(new Date());
		System.out.println("chatContent = " + chat.getChatContent());
		
		return chat;
	}
	
	@RequestMapping("/enter/chat/{roomNo}")
	public String enterChat (@PathVariable ("roomNo") int roomNo, Model model) {
		model.addAttribute("roomNo", roomNo);
		return "chatting";
	}

}
