package egovframework.mumukgang.cmmn.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.enterprise.inject.New;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
import egovframework.mumukgang.cmmn.web.vo.Chnum;
import egovframework.mumukgang.cmmn.web.vo.Friends;
import reactor.util.annotation.Nullable;

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
		List<HashMap<String, Object>> chcreater;
		List<String> namelist = new ArrayList<String>();

		String loginemail = (String) session.getAttribute("email");
		map.put("email", loginemail);
		
		System.out.println("mapper 전");
		
		
		friendslist = membermapper.friendslist(map);
		
		//참여중인 채널 번호
		chlist = channelmapper.participatingch(map);
		//loginid가 만든 채널번호
		chcreater = channelmapper.chhost(map);
		
		System.out.println(chcreater);
		
		map.clear();

			
		//참여중인 채널의 제목
		for(Map<String, Object> data : chlist) {
			
			map.put("ch_num", data.get("chNum"));

			if (String.valueOf(chcreater).contains(data.get("chNum").toString())) {
				System.out.println("들어옴");
				String chname = "*" + (String)channelmapper.selectchname(map).get("ch_name");
				namelist.add(chname);
			}
			else {
				String chname = (String)channelmapper.selectchname(map).get("ch_name");
				namelist.add(chname);
			}
			
		}
		
		System.out.println(namelist);
		
		model.addAttribute("namelist", namelist);
		model.addAttribute("chlist", chlist);
		model.addAttribute("friendslist", friendslist);
			
		return "home/ChannelList";
	}
	
	
	/***
	 * 채널 만들기
	 * 
	 * */
	@RequestMapping(value="/createchannel", method=RequestMethod.POST)
	@ResponseBody
	public Object requestFriends(
			@RequestParam(value="selectlist[]", required = false) List<String> list,
			@RequestParam(value="channelname") String chname,
			@RequestParam(value="chtype") Boolean chtype,
			@RequestParam(value="chregion", required = false) String chregion,
			HttpSession session) {
		System.out.println("createchannel 진입");
		System.out.println("chtype == " + chtype);
		String loginid = (String) session.getAttribute("email");
		
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		System.out.println(latestDate);
		
		ChannelMember channelMember2 = new ChannelMember();
		Channel channel = new Channel();
		channel.setCh_create_email(loginid);
		channel.setCh_name(chname);
		channel.setCh_date(latestDate);
		channel.setCh_type(chtype);
		channel.setCh_region(chregion);
		
		channelmapper.createchannel(channel);
		int createChnum = channel.getCh_num();
		
		channelMember2.setCh_num(createChnum);
		channelMember2.setEmail(loginid);
		channelmapper.channelmember(channelMember2);
		if (list != null) {
			for(int i=0; i < list.size(); i++) {
				channelMember2.setCh_num(createChnum);
				channelMember2.setEmail(list.get(i));
				channelmapper.channelmember(channelMember2);
				System.out.println("list = " + channelMember2);
			}
		}
		
				
		//리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        //성공했다고 처리
        retVal.put("code", "OK");
        retVal.put("message", "등록에 성공 하였습니다.");
        
        return retVal;
 
	}
	
	
	/***
	 * 채널 삭제
	 * 
	 * */
	@RequestMapping(value="/deletechannel", method=RequestMethod.POST)
	@ResponseBody
	public Object deleteChannel(@RequestParam(value="roomNo") String roomNo, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("roomNo", roomNo);
		map.put("email", session.getAttribute("email"));
		int result = channelmapper.delauthority(map);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		if (result > 0) {
			channelmapper.delchannel(map);
			//리턴값
	        retVal.put("code", "OK");
	        retVal.put("message", "삭제에 성공 하였습니다.");
			return retVal;
		}else {
			  retVal.put("code", "NO");
		        retVal.put("message", "삭제 권한이 없습니다.");
				return retVal;
		}
		
	}
	
	
	/***
	 * 채널찾기 view 및 검색
	 * 
	 * */
	@RequestMapping(value="/findchannel")
	public String findChannel(@RequestParam(required = false) HashMap<String, Object> map, Model model) {
		String keyword = (String) map.get("findchannel");
		String chregion = (String) map.get("region");
		System.out.println(chregion);
		//System.out.println(chregion.equals("전체"));
		
		if (chregion != null && (chregion.equals("전체") || chregion.equals("지역선택"))) {
			System.out.println("전체");
			model.addAttribute("chlist", channelmapper.findpublicch());
			return "home/FindChannel";
		}
		else if (keyword != null && chregion.equals("전체")) {
			System.out.println("searchpublicch");
			model.addAttribute("chlist", channelmapper.searchpublicch(keyword));
			return "home/FindChannel";
		}
		else if (keyword != null && chregion != null) {
			System.out.println("searchpublicchwithregion");
			System.out.println(map);
			model.addAttribute("chlist", channelmapper.searchpublicchwithregion(map));
			return "home/FindChannel";
		}
		else if(chregion != null){
			System.out.println("searchpublicchregion");
			model.addAttribute("chlist", channelmapper.searchpublicchregion(chregion));
			return "home/FindChannel";
		}
		else {
			model.addAttribute("chlist", channelmapper.findpublicch());
			return "home/FindChannel";
		}
		
	}
//	
//	/***
//	 * 채널검색
//	 * 
//	 * */
//	@RequestMapping(value="/searchch", method=RequestMethod.POST)
//	public String searchChannel(@RequestParam HashMap<String, Object> map, Model model) {
//		String keyword = (String) map.get("findchannel");
//		System.out.println(channelmapper.searchpublicch(keyword));
//		model.addAttribute("chlist", channelmapper.searchpublicch(keyword));
//		return "home/FindChannel";
//	}
}
