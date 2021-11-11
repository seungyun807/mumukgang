package egovframework.mumukgang.cmmn.web.chat.controller;



import java.util.Date;
import java.util.HashMap;
import java.util.List;

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
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> chcreater;
		
		channelmember.setCh_num(roomNo);
		channelmember.setEmail(loginid);
		map.put("email", loginid);
		chcreater = channelmapper.chhost(map);
		int chtype = channelmapper.ispublicch(channelmember);
		
		int result = channelmapper.authoritychannel(channelmember);
		int countchmem = channelmapper.countchmem(roomNo);
		
		model.addAttribute("chcreater", chcreater);
		model.addAttribute("countchmem", countchmem);
		model.addAttribute("roomNo", roomNo);
		model.addAttribute("foodlist", channelmapper.selectfood());
		System.out.println(channelmapper.selectfood());
		
		if (chtype > 0) {
			map.put("ch_num", roomNo);
			String chname = (String)channelmapper.selectchname(map).get("ch_name");
			//String chtype = (String)channelmapper.selectchtype(map).get("ch_type");
			model.addAttribute("chname", chname);
			model.addAttribute("chtype", Integer.toString(chtype));
			return "chat/chatting";
		}
		else if(result > 0) {
			map.put("ch_num", roomNo);
			String chname = (String)channelmapper.selectchname(map).get("ch_name");
			model.addAttribute("chtype", Integer.toString(chtype));
			model.addAttribute("chname", chname);
			return "chat/chatting";
		}
		else {
			
			return "chat/authorityrefuse";
		}
		
		
	}

}
