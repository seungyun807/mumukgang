package egovframework.mumukgang.cmmn.web.chat.controller;



import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
import egovframework.mumukgang.cmmn.web.mapper.ChannelMapper;
import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
	@Resource
	ChannelMapper channelmapper;
	
	@MessageMapping("/hello/{roomNo}")
	@SendTo("/subscribe/chat/{roomNo}")
	public Chat broadcasting(Chat chat) {
		chat.setSendDate(new Date());
		System.out.println("chatContent = " + chat +" nick = " + chat.getMemberId());
		
		return chat;
	}
	
	@RequestMapping("/enter/chat/{roomNo}")
	public String enterChat (@PathVariable ("roomNo") int roomNo, Model model, HttpSession session) {
		String loginid = (String)session.getAttribute("email");
		ChannelMember channelmember = new ChannelMember();
		
		
		channelmember.setCh_num(roomNo);
		channelmember.setEmail(loginid);
		
		int result = channelmapper.authoritychannel(channelmember);
		System.out.println(result);
		
		model.addAttribute("roomNo", roomNo);
		
		if(result > 0) {
			return "chat/chatting";
		}
		else {
			
			return "chat/authorityrefuse";
		}
		
		
	}

}
