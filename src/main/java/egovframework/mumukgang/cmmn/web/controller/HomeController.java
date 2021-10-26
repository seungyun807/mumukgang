package egovframework.mumukgang.cmmn.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;

@Controller
public class HomeController {

	@Resource
	MemberMapper membermapper;
	
	@RequestMapping(value="/home")
	public String viewHome() {
		return "home/Home";
	}
	
	
	/***
	 * 친구 리스트 불러오기
	 * 
	 */
	@RequestMapping(value="/friendslist")
	public String viewFriendsList(Model model, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> map2;
		String loginemail = (String) session.getAttribute("email");
		map.put("email", loginemail);
		System.out.println("mapper 전");
		map2 = membermapper.friendslist(map);
		System.out.println("friendlist = " + map2.get(0));
		model.addAttribute("friendslist", map2);
		
		return "home/FriendsList";
	}
	
	
	/***
	 * 친구찾기 view
	 * 
	 */
	@RequestMapping(value="/findfriends")
	public String viewFindFriend(Model model, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String loginEmail = (String) session.getAttribute("email");
		map.put("res_email", loginEmail);
		model.addAttribute("resfriends", membermapper.receivedfriendrequest(map));
		return "home/FindFriend";
	}
	
	
	/***
	 * DB 친구 찾기
	 * 
	 */
	@RequestMapping(value="/findfriendsdo", method=RequestMethod.POST)
	public String findFriend(@RequestParam HashMap<String, Object> param, Model model) {
		
		System.out.println("findfriendsdo");
		
		model.addAttribute("findfriend", membermapper.findfriendsnickname(param));
		
		return "forward:/findfriends";
	}
	
	
	/***
	 * 친구 요청
	 * 
	 */
	@RequestMapping(value="/requestfriends", method=RequestMethod.POST)
	public String requestFriends(@RequestParam HashMap<String, Object> param, HttpSession session) {
		System.out.println("requestFriends");
		System.out.println("requestFriends = " + param);
		
		String loginEmail = (String) session.getAttribute("email");
		
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		param.put("req_email", loginEmail);
		param.put("request_time", latestDate);
		membermapper.requestfriends(param);
		return "forward:/findfriends";
		
	}
	
}
