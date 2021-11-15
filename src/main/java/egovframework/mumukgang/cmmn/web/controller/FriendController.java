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

import egovframework.mumukgang.cmmn.web.mapper.FriendMapper;
import egovframework.mumukgang.cmmn.web.vo.FriendReq;
import lombok.experimental.var;

@Controller
public class FriendController {

	@Resource
	FriendMapper friendMapper;
	
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
		
		map2 = friendMapper.friendslist(map);
		
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
		List<Map<String, Object>> receivedlist;
		List<Map<String, Object>> requestlist;
		
		String loginEmail = (String) session.getAttribute("email");
		map.put("email", loginEmail);
		
		receivedlist = friendMapper.receivedfriendrequest(map);
		requestlist = friendMapper.requestfriendslist(map);
		
		for(int i=0; i<receivedlist.size(); i++) {
			receivedlist.get(i).put("index", i);
		}
		
		for(int i=0; i<requestlist.size(); i++) {
			requestlist.get(i).put("index", i);
		}
		
		model.addAttribute("resfriends", receivedlist);
		model.addAttribute("reqfriends", requestlist);
		return "home/FindFriend";
	}
	
	/***
	 * 친구요청 수락 및 거절
	 * 
	 */
	@RequestMapping(value="/acceptfriends", method=RequestMethod.POST)
	@ResponseBody
	public void acceptFriends(@RequestParam(value="index") int req_index, @RequestParam(value="refuse") boolean refuse, HttpSession session) {
		
		String loginEmail = (String) session.getAttribute("email");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2;
		FriendReq friendReq = new FriendReq();
		
		map.put("email", loginEmail);
		List<Map<String, Object>> listmap;
		
		if(!refuse) {
			// 요청한 사람 불러오기 listmap
			listmap = friendMapper.receivedfriendrequest(map);
		} else {
			listmap = friendMapper.requestfriendslist(map);
		}
		
		map2 = listmap.get(req_index);
		
		//친구요청 거절시
		friendMapper.acceptfriends(map2);
		
		// 친구요청 수락시
		if (!refuse) {
			System.out.println("친구요청수락");
			//INSERT
			friendReq.setReq_email((String) map2.get("reqEmail"));
			friendReq.setReq_nickname((String) map2.get("reqNickname"));
			friendReq.setRes_email((String) map2.get("resEmail"));
			friendReq.setRes_nickname((String) map2.get("resNickname"));
			
			friendMapper.addtofriends(friendReq);
			friendMapper.addtofriends2(friendReq);
		}
		
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
		System.out.println("friendMapper.findfriendsnickname(param) = " + friendMapper.findfriendsnickname(param));
		
		map = friendMapper.findfriendsnickname(param);
		
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
		if(friendMapper.finddupfriends(param) > 0) {
			System.out.println("중복거르기" + friendMapper.finddupfriends(param));
			System.out.println(friendMapper.receivedfriendrequest(param));
			return "이미 등록된 친구입니다.";
		} 
		else if (friendMapper.selectfriendrequest(param) > 0) {
			return "이미 요청된 친구입니다.";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		map.put("email", loginEmail);
		map = friendMapper.selectnickname(map); 
		String nickname = (String) map.get("nickname"); 
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		param.put("req_email", loginEmail);
		param.put("req_nickname", nickname);
		param.put("request_time", latestDate);
		int result = friendMapper.requestfriends(param);
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
		
		friendMapper.delfriend(param);
		
		return "성공";
		
	
	}
}
