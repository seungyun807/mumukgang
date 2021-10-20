package egovframework.mumukgang.cmmn.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.json.Json;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;

@Controller
public class LoginController {

	@Resource
	MemberMapper membermapper;
	
	@RequestMapping(value="/joinview")
	public String viewJoin() {return "member/Join"; }
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public void Join(@RequestParam HashMap<String, Object> params) throws Exception{
		System.out.println("/join param = " + params);
		membermapper.UserJoin(params);
		
	}
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public void login(@RequestParam HashMap<String, Object> params, HttpSession session, Model model) throws Exception{
		Json json = (Json) session.getAttribute("cast");
		
		System.out.println("/login param = " + json);
		
	}
	
	@RequestMapping(value="/idcheck")
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam Map<String, Object> param) throws Exception{
		int result = membermapper.UserIdCheck((String) param.get("checkId"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usedCnt", result);
		System.out.println(result);
		return map;
	}
}
