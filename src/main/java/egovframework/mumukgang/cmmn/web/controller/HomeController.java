package egovframework.mumukgang.cmmn.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.integration.dsl.StandardIntegrationFlow;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;
import lombok.experimental.var;

@Controller
public class HomeController {

	@Resource
	MemberMapper membermapper;
	
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
		
			System.out.println("friendlist = " + map2);
			model.addAttribute("friendslist", map2);
		
		
		
		return "home/FriendsList";
	}
	
	
	/***
	 * 친구찾기 view 및 친구요청 불러오기
	 * 
	 */
	@RequestMapping(value="/findfriends")
	public String viewFindFriend(Model model, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> listmap;
		
		
		String loginEmail = (String) session.getAttribute("email");
		map.put("res_email", loginEmail);
		
		System.out.println(membermapper.receivedfriendrequest(map));
		listmap = membermapper.receivedfriendrequest(map);
		
		for(int i=0; i<listmap.size(); i++) {
			listmap.get(i).put("index", i);
			System.out.println(listmap.get(i));
		}
		
		model.addAttribute("resfriends", listmap);
		return "home/FindFriend";
	}
	
	/***
	 * 친구요청 수락
	 * 
	 */
	@RequestMapping(value="/acceptfriends", method=RequestMethod.POST)
	@ResponseBody
	public void acceptFriends(@RequestParam HashMap<String, Object> param, HttpSession session) {
		System.out.println(param);
		String loginEmail = (String) session.getAttribute("email");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2;
		
		map.put("res_email", loginEmail);
		List<Map<String, Object>> listmap;
		
		// 요청한 사람 불러오기 listmap
		listmap = membermapper.receivedfriendrequest(map);
		
		int req_index = Integer.parseInt((String) param.get("index"));
		map2 = listmap.get(req_index);
		
		String req_email = (String) map2.get("reqEmail");
		String req_nickname = (String) map2.get("reqNickname");
		String res_email = (String) map2.get("resEmail");
		String res_nickname = (String) map2.get("resNickname");
		
		HashMap<String, Object> map3 = new HashMap<String, Object>();
		map3.put("req_email", req_email);
		map3.put("req_nickname", req_nickname);
		map3.put("res_email", res_email);
		map3.put("res_nickname", res_nickname);
		
		//DELETE
		membermapper.acceptfriends(map3);
		
		//INSERT
		System.out.println(membermapper.addtofriends(map3));
		System.out.println(membermapper.addtofriends2(map3));
		
		System.out.println(map2);
	}
	
	/***
	 * DB 친구 찾기
	 * 
	 */
	@RequestMapping(value="/findfriendsdo", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> findFriend(@RequestParam HashMap<String, Object> param, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		System.out.println("findfriendsdo = " + param);
		System.out.println("membermapper.findfriendsnickname(param) = " + membermapper.findfriendsnickname(param));
		
		map = membermapper.findfriendsnickname(param);
		
		String findnick = (String)map.get("email");
		String loginnick = (String)session.getAttribute("email");

		if (findnick.equals(loginnick)) {
			return null;
		}
		
		return map;
	}
	
	
	/***
	 * 친구 요청
	 * 
	 */
	@RequestMapping(value="/requestfriends", method=RequestMethod.POST)
	@ResponseBody
	public String requestFriends(@RequestParam HashMap<String, Object> param, HttpSession session) {
		System.out.println("requestFriends");
		System.out.println("requestFriends = " + param);
		String loginEmail = (String) session.getAttribute("email");
		
		param.put("email", loginEmail);
		
				//중복 거르기
		if(membermapper.finddupfriends(param) > 0) {
			System.out.println("중복거르기" + membermapper.finddupfriends(param));
			System.out.println(membermapper.receivedfriendrequest(param));
			return "이미 등록된 친구입니다.";
		} 
		else if (membermapper.selectfriendrequest(param) > 0) {
			return "이미 요청된 친구입니다.";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		map.put("email", loginEmail);
		map = membermapper.selectnickname(map); 
		String nickname = (String) map.get("nickname"); 
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		param.put("req_email", loginEmail);
		param.put("req_nickname", nickname);
		param.put("request_time", latestDate);
		int result = membermapper.requestfriends(param);
		System.out.println("request result = " + result);
		return "성공";
		
	}
	
	
	/***
	 * 친구 삭제
	 * 
	 */
	@RequestMapping(value="/delfriend", method=RequestMethod.POST)
	@ResponseBody
	public String delFriend(@RequestParam HashMap<String, Object> param, HttpSession session) {
		String loginid = (String)session.getAttribute("email");
		
		param.put("email", loginid);
		
		membermapper.delfriend(param);
		
		return "성공";
		
	
	}
}
