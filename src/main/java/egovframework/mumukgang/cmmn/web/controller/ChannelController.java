package egovframework.mumukgang.cmmn.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.mail.handlers.image_gif;

import egovframework.mumukgang.cmmn.web.mapper.ChannelMapper;
import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;
import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import egovframework.mumukgang.cmmn.web.vo.Friends;

@Controller
public class ChannelController {
	
	@Resource
	MemberMapper membermapper;
	@Resource
	ChannelMapper channelmapper;
	
	
	/***
	 * 채널 메뉴 view
	 * 
	 * */
	@RequestMapping(value="/channel")
	public String viewChannel(Model model, HttpSession session) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> friendslist;
		List<HashMap<String, Object>> chlist;
		List<String> namelist = new ArrayList<String>();

		String loginemail = (String) session.getAttribute("email");
		map.put("email", loginemail);
		
		System.out.println("mapper 전");
		
		friendslist = membermapper.friendslist(map);
		chlist = channelmapper.participatingch(map);
		map.clear();
	
		for(Map<String, Object> data : chlist) {
			
			map.put("ch_num", data.get("chNum"));
			String chname = (String)channelmapper.selectchname(map).get("ch_name");
			namelist.add(chname);
			
		}
		System.out.println(namelist);
		
		model.addAttribute("namelist", namelist);
		model.addAttribute("chlist", chlist);
		model.addAttribute("friendslist", friendslist);
			
		return "home/channel";
	}
	
	
	/***
	 * 채널 만들기
	 * 
	 * */
	@RequestMapping(value="/createchannel", method=RequestMethod.POST)
	@ResponseBody
	public Object  requestFriends(@RequestParam(value="selectlist[]") List<String> list, @RequestParam(value="channelname") String chname, HttpSession session) {
		System.out.println(chname);
		System.out.println(list);
		String loginid = (String) session.getAttribute("email");
		
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		System.out.println(latestDate);
		
		ChannelMember channelMember2 = new ChannelMember();
		Channel channel = new Channel();
		channel.setCh_create_email(loginid);
		channel.setCh_name(chname);
		channel.setCh_date(latestDate);
		
		
		channelmapper.createchannel(channel);
		int createChnum = channel.getCh_num();
		
		channelMember2.setCh_num(createChnum);
		channelMember2.setEmail(loginid);
		channelmapper.channelmember(channelMember2);
		
	
		for(int i=0; i < list.size(); i++) {
			channelMember2.setCh_num(createChnum);
			channelMember2.setEmail(list.get(i));
			channelmapper.channelmember(channelMember2);
			System.out.println("list = " + channelMember2);
		}
		


		
		//리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        //성공했다고 처리
        retVal.put("code", "OK");
        retVal.put("message", "등록에 성공 하였습니다.");
        
        return retVal;
 
	}
	
	
}
