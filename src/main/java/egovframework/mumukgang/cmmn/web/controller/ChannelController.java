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
import javax.validation.constraints.Null;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.ls.LSInput;

import com.sun.mail.handlers.image_gif;

import egovframework.mumukgang.cmmn.web.mapper.ChannelMapper;
import egovframework.mumukgang.cmmn.web.mapper.FriendMapper;
import egovframework.mumukgang.cmmn.web.mapper.MenuMapper;
import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelInvited;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import egovframework.mumukgang.cmmn.web.vo.Chnum;
import egovframework.mumukgang.cmmn.web.vo.Friends;
import egovframework.mumukgang.cmmn.web.vo.Pagination;
import reactor.util.annotation.Nullable;

@Controller
public class ChannelController {
	
	@Resource
	FriendMapper friendMapper;
	@Resource
	ChannelMapper channelMapper;
	@Resource
	MenuMapper menuMapper;
	
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
		List<Boolean> createrTorN = new ArrayList<Boolean>();
		
		String loginemail = (String) session.getAttribute("email");
		map.put("email", loginemail);
		
		friendslist = friendMapper.friendslist(map);
		
		//참여중인 채널 번호
		chlist = channelMapper.participatingch(map);
		//loginid가 만든 채널번호
		chcreater = channelMapper.chhost(map);
		
		map.clear();

			
		//참여중인 채널의 제목
		for(Map<String, Object> data : chlist) {
			
			map.put("ch_num", data.get("chNum"));

			if (String.valueOf(chcreater).contains(data.get("chNum").toString())) {
				createrTorN.add(true);
				//String chname = "*" + (String)channelMapper.selectchname(map).get("ch_name");
				namelist.add((String)channelMapper.selectchname(map).get("ch_name"));
			}
			else {
				createrTorN.add(false);
				//String chname = (String)channelMapper.selectchname(map).get("ch_name");
				namelist.add((String)channelMapper.selectchname(map).get("ch_name"));
			}
			
		}
		
		System.out.println(createrTorN);
		
		model.addAttribute("createrTorN", createrTorN);
		model.addAttribute("chinvited", channelMapper.selectchinvited(loginemail));
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
		String loginid = (String) session.getAttribute("email");
		String loginnick = (String) session.getAttribute("nickname");
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		System.out.println(latestDate);
		
		ChannelMember channelMember = new ChannelMember();
		ChannelInvited chInvited = new ChannelInvited(); 
		Channel channel = new Channel();
		channel.setCh_create_email(loginid);
		channel.setCh_name(chname);
		channel.setCh_date(latestDate);
		channel.setCh_type(chtype);
		channel.setCh_region(chregion);
		
		channelMapper.createchannel(channel);
		int createChnum = channel.getCh_num();
		
		channelMember.setCh_num(createChnum);
		channelMember.setEmail(loginid);
		channelMember.setJoin_date(latestDate);
		channelMapper.channelmember(channelMember);
		
			
		if (list != null) {
			chInvited.setReq_email(loginid);
			chInvited.setCh_num(createChnum);
			chInvited.setCh_name(chname);
			chInvited.setRequest_time(latestDate);
			chInvited.setNickname(loginnick);
			
			for(int i=0; i < list.size(); i++) {	
				chInvited.setRes_email(list.get(i));
				channelMapper.channelinvited(chInvited);
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
	 * 채널 수정
	 * 
	 * */
	@RequestMapping(value="/updatechannel", method=RequestMethod.POST)
	@ResponseBody
	public Object updateChannel(
			@RequestParam(value="selectlist[]", required = false) List<String> updateList,
			@RequestParam(value="channelname") String chname,
			@RequestParam(value="chtype") Boolean chtype,
			@RequestParam(value="chregion", required = false) String chregion,
			@RequestParam(value="chnum") int ch_num,
			HttpSession session) {
		
		System.out.println("updatechannel 진입");
		String loginid = (String) session.getAttribute("email");
		String loginnick = (String) session.getAttribute("nickname");
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		
		//System.out.println(latestDate);
		
		ChannelMember channelMember = new ChannelMember();
		ChannelInvited chInvited = new ChannelInvited(); 
		Channel channel = new Channel();
		channel.setCh_num(ch_num);
		channel.setCh_create_email(loginid);
		channel.setCh_name(chname);
		//channel.setCh_date(latestDate);
		channel.setCh_type(chtype);
		channel.setCh_region(chregion);
		
		channelMapper.updatech(channel);
		
		
		List<String> memberList = channelMapper.selectchmember(ch_num);
		memberList.remove(loginid);
		System.out.println(memberList);
		
		
		//이미 존재하는 친구 삭제 및 새로운 친구 초대
		if (updateList != null) {
			
			int size = updateList.size();
			
			for(int i = 0; i<size; i++) {
				if(memberList.remove(updateList.get(i))) {
					updateList.set(i, "");
				}
			}
			
			chInvited.setReq_email(loginid);
			chInvited.setCh_num(ch_num);
			chInvited.setCh_name(chname);
			chInvited.setRequest_time(latestDate);
			chInvited.setNickname(loginnick);
			
			//새로운 친구 초대
			for(int i=0; i < updateList.size(); i++) {	
				if(updateList.get(i) != "") {
				chInvited.setRes_email(updateList.get(i));
				channelMapper.channelinvited(chInvited);
				}
			}
			
			//삭제된 친구 update
			for(int i=0; i < memberList.size(); i++) {	
				channelMember.setCh_num(ch_num);
				channelMember.setEmail(memberList.get(i));
				channelMapper.updatedelchmember(channelMember);
			}
		}
		
		//리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        //성공했다고 처리
        retVal.put("code", "OK");
        retVal.put("message", "수정에 성공 하였습니다.");
        
        return retVal;
 
	}
	
	
	/***
	 * 채널 요청 수락여부
	 * 
	 */
	/**
	 * @param chnum
	 * @param aon
	 * @param session
	 * @return
	 */
	@PostMapping(value="/chreqaon")
	@ResponseBody
	public Object chReqAcceptance(@RequestParam(value="chnum") int chnum, @RequestParam(value="acceptornot") boolean aon, HttpSession session) {	
		Map<String, Object> retVal = new HashMap<String, Object>();
		ChannelMember channelMember = new ChannelMember();
		SimpleDateFormat currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String latestDate = currentDateTime.format(new Date()).toString();
		String loginId = (String) session.getAttribute("email");
		
		channelMember.setCh_num(chnum);
		channelMember.setEmail(loginId);
		channelMember.setJoin_date(latestDate);
 		if (aon) {
			channelMapper.channelmember(channelMember);
			retVal.put("code", "OK");
			retVal.put("message",  "초대를 수락하였습니다.");
		} else {
			retVal.put("code", "NO");
			retVal.put("message", "초대를 거절하였습니다.");
		}
		channelMapper.deleteinvited(channelMember);
		
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
		int result = channelMapper.delauthority(map);
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		if (result > 0) {
			channelMapper.delchannel(map);
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
	 * 채널 나가기
	 * 
	 * */
	@RequestMapping(value="/outchannel", method=RequestMethod.POST)
	@ResponseBody
	public Object outChannel(@RequestParam(value="roomNo") int roomNo, HttpSession session) {
		ChannelMember channelMember = new ChannelMember();
		channelMember.setCh_num(roomNo);
		channelMember.setEmail((String) session.getAttribute("email"));
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		
			channelMapper.updatedelchmember(channelMember);
			//리턴값
	        retVal.put("code", "OK");
	        retVal.put("message", "채널에서 나갔습니다.");
			return retVal;
	}
	
	
	/***
	 * 채널찾기 view 및 검색
	 * 
	 * */
	@RequestMapping(value="/findchannel")
	public String findChannel(
			@RequestParam(required = false) HashMap<String, Object> map,  
			@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(value="mycop", required=false) Boolean cop,
			Model model, 
			HttpSession session) {
		String keyword = (String) map.get("findchannel");
		String chregion = (String) map.get("region");
		System.out.println("/findchannel = " + cop);
		HashMap<String, Object> temp = new HashMap<String, Object>();
		//System.out.println(chregion.equals("전체"));
		if(cop != null) {
			if(cop) {
				int listCnt = channelMapper.findmycopCnt((String) session.getAttribute("email"));
				int start = (curPage-1)*10;
				Pagination pagination = new Pagination(listCnt, curPage);
				temp.put("email", session.getAttribute("email"));
				temp.put("start", start);
				model.addAttribute("chlist", channelMapper.findmycop(temp));
				model.addAttribute("pagination", pagination);
				return "home/FindChannel";
			}
		}
		
		if (keyword != null && (chregion.equals("전체") || chregion.equals("지역선택"))) {
			int listCnt = channelMapper.searchpublicchCnt(keyword);
			int start = (curPage-1)*10;
			Pagination pagination = new Pagination(listCnt, curPage);
			temp.put("keyword", keyword);
			temp.put("start", start);
			model.addAttribute("chlist", channelMapper.searchpublicch(temp));
			model.addAttribute("pagination", pagination);
			
		}
		else if (chregion != null && (chregion.equals("전체") || chregion.equals("지역선택"))) {
			int listCnt = channelMapper.findpublicchCnt();
			int start = (curPage-1)*10;
			Pagination pagination = new Pagination(listCnt, curPage);
			
			model.addAttribute("chlist", channelMapper.findpublicch(start));
			model.addAttribute("pagination", pagination);
		
		}
		else if (keyword != null && chregion != null) {
			int listCnt = channelMapper.searchpublicchwithregionCnt(map);
			int start = (curPage-1)*10;
			Pagination pagination = new Pagination(listCnt, curPage);
			map.put("start", start);
			model.addAttribute("chlist", channelMapper.searchpublicchwithregion(map));
			model.addAttribute("pagination", pagination);
		}
		else if(chregion != null){
			int listCnt = channelMapper.searchpublicchregionCnt(chregion);
			int start = (curPage-1)*10;
			Pagination pagination = new Pagination(listCnt, curPage);
			temp.put("region", chregion);
			temp.put("start", start);
			model.addAttribute("chlist", channelMapper.searchpublicchregion(temp));
			model.addAttribute("pagination", pagination);
		}
		else {
			int listCnt = channelMapper.findpublicchCnt();
			int start = (curPage-1)*10;
			Pagination pagination = new Pagination(listCnt, curPage);
			
			
			model.addAttribute("chlist", channelMapper.findpublicch(start));
			model.addAttribute("pagination", pagination);
			
		}
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("chregion", chregion);
		return "home/FindChannel";
		
	}
	
	
	/***
	 * 채널 설정
	 * 
	 * */
	@RequestMapping(value="/settingch", method=RequestMethod.POST)
	@ResponseBody
	public Object settingChannel(@RequestParam(value="chnum") String chnum, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<String> list = channelMapper.selectchmember(Integer.parseInt(chnum));
		list.remove(session.getAttribute("email"));
		map = channelMapper.selectchinfo(Integer.parseInt(chnum));
		map.put("chmember", list);
		return map;
	}
	
	
	/***
	 * 채널별 pick 메뉴 저장 및 삭제
	 * 
	 * */
	@RequestMapping(value="/pickmenu", method=RequestMethod.POST)
	@ResponseBody
	public void pickmenu(@RequestParam(value="pickid", required = false) String pick, @RequestParam(value="roomNo") int chnum, @RequestParam(value="del") boolean del, @RequestParam(value="empty") boolean empty ) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ch_num", chnum);
		map.put("food_name", pick);
		if(del) {
			menuMapper.delmenupick(map);
		} else if(empty){
			menuMapper.delchmenu(map);
		} else {
			menuMapper.menupick(map);
		}
	}
}
