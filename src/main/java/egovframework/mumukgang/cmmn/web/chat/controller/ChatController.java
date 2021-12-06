package egovframework.mumukgang.cmmn.web.chat.controller;



import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.enterprise.context.Conversation;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.mumukgang.cmmn.web.chat.Messaging;
import egovframework.mumukgang.cmmn.web.chat.StompHandler;
import egovframework.mumukgang.cmmn.web.chat.model.vo.Chat;
import egovframework.mumukgang.cmmn.web.mapper.ChannelMapper;
import egovframework.mumukgang.cmmn.web.mapper.MenuMapper;
import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import junit.framework.Test;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
	@Resource
	ChannelMapper channelmapper;
	@Resource
	MenuMapper menumapper;
	
	
	private SimpMessagingTemplate template;
	
	@Autowired
 	private Messaging messaging;
	
	 @Autowired
	    public ChatController(SimpMessagingTemplate template) {
	        this.template = template;
	    }

	
	@MessageMapping("/hello/{roomNo}")
	@SendTo("/subscribe/chat/{roomNo}")
	public Chat broadcasting(Chat chat) {
		chat.setSendDate(new Date());
		System.out.println("chatContent = " + chat.getChatContent() +" chat = " + chat);
		if(chat.getChatContent() != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("ch_num", chat.getRoomNo());
			map.put("nickname", chat.getMemberId());
			map.put("content", chat.getChatContent());
			channelmapper.saveChat(map);
		}
		//setTemplate(template);
	    //this.template.convertAndSend("/subscribe/chat/24", chat);
	   // messaging.checkNotice(this.template);
		return chat;
	}
	
	@MessageMapping("/test/{roomNo}")
	@SendTo("/subscribe/chat/{roomNo}")
	public Chat test(Chat chat) {
		chat.setSendDate(new Date());
		System.out.println("chatContent = " + chat +" nick = " + chat.getMemberId());
		//setTemplate(template);
	    this.template.convertAndSend("/subscribe/chat/24", chat);
		return chat;
	}

	@RequestMapping("/enter/chat/{roomNo}")
	public String enterChat (@PathVariable ("roomNo") int roomNo, Model model, HttpSession session) {
		String loginid = (String)session.getAttribute("email");
		
		List<HashMap<String, Object>> jjim;
		List<HashMap<String, Object>> guktang;
		List<HashMap<String, Object>> jjigae;
		List<HashMap<String, Object>> myeon;
		List<HashMap<String, Object>> haejang;
		
		List<HashMap<String, Object>> japan;
		List<HashMap<String, Object>> china;
		List<HashMap<String, Object>> asianweston;
		List<HashMap<String, Object>> convenience;
		List<HashMap<String, Object>> fastfood;
		List<HashMap<String, Object>> bunsick;
		
		jjim = menumapper.jjim();
		guktang = menumapper.guktang();
		jjigae = menumapper.jjigae();
		myeon = menumapper.myeon();
		haejang = menumapper.haejang();
		
		japan = menumapper.selectJapanese();
		china = menumapper.selectChinese();
		asianweston = menumapper.selectAsianWestern();
		convenience = menumapper.selectConvenience();
		fastfood = menumapper.selectFastFood();
		bunsick = menumapper.selectBunsick();
		
		model.addAttribute("jjim", jjim);
		model.addAttribute("guktang", guktang);
		model.addAttribute("jjigae", jjigae);
		model.addAttribute("myeon", myeon);
		model.addAttribute("haejang", haejang);
		
		model.addAttribute("japan", japan);
		model.addAttribute("china", china);
		model.addAttribute("asianweston", asianweston);
		model.addAttribute("convenience", convenience);
		model.addAttribute("fastfood", fastfood);
		model.addAttribute("bunsick", bunsick);
		
		
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
		model.addAttribute("pickmenu", menumapper.selmenupick(roomNo));
		
		System.out.println(channelmapper.selectChat(roomNo));
		model.addAttribute("chatcontentlist", channelmapper.selectChat(roomNo));
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
