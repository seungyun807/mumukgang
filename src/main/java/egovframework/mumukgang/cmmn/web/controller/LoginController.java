package egovframework.mumukgang.cmmn.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.json.Json;
import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.deser.impl.CreatorCandidate.Param;

import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;

@Controller
public class LoginController {

	@Resource
	MemberMapper membermapper;
	
	/***
	 * 회원가입
	 * 
	 */
	@RequestMapping(value="/joinview")
	public String viewJoin() {return "member/Join"; }
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String Join(@RequestParam HashMap<String, Object> params, Model model) throws Exception{
		System.out.println("/join param = " + params);
		int result = membermapper.UserJoin(params);
		if(result > 0) {
			model.addAttribute("joinmsg", "success");
			return "forward:/joinview";
		}else {
			model.addAttribute("joinmsg", "failed");
			return "forward:/joinview";
		}
	}
	
	/***
	 * 아이디 중복확인
	 * 
	 */
	@RequestMapping(value="/idcheck")
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam Map<String, Object> param) throws Exception{
		int result = membermapper.UserIdCheck((String) param.get("checkId"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usedCnt", result);
		System.out.println(result);
		return map;
	}
	
	/***
	 * 닉네임 중복확인
	 * 
	 */
	@RequestMapping(value="/nickcheck")
	@ResponseBody
	public Map<String, Object> nickCheck(@RequestParam Map<String, Object> param) throws Exception{
		int result = membermapper.UserNickCheck((String) param.get("checkNick"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usedCnt", result);
		System.out.println(result);
		return map;
	}
	
	/***
	 * 로그인 성공
	 * 
	 */
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam HashMap<String, Object> params, HttpSession session, Model model) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		HashMap<String, Object> nickname = new HashMap<String, Object>();
		
		int result = membermapper.loginCheck(params);
		
		String email = params.get("email").toString();
		System.out.println("/login email = " + email);
		model.addAttribute("map", map);
		
		if(result != 0) {
			  nickname = membermapper.selectEandNick(params);
			 
			  session.setAttribute("email", email);
			  session.setAttribute("nickname", (String)nickname.get("nickname"));
			  
			  map.put("userName", email);
			  map.put("msg", "success");
			  
	      } else {
	    	  System.out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
	    	  map.put("msg", "failure");
	    	  return "forward:/intro";
	      }
		
		return "forward:/findchannel";
	}
	
	/***
	 * 카카오 로그인 성공
	 * 
	 */
	@ResponseBody
	@PostMapping(value="/kakaologin")
	public String kakaologin(@RequestParam HashMap<String, Object> params, HttpSession session) throws Exception {
		HashMap<String, Object> nickname = new HashMap<String, Object>();

		String email = (String)params.get("email");
		
		
		if (email != null) {
			System.out.println("kakaologin = " + email );
			nickname = membermapper.selectEandNick(params);
			session.setAttribute("email", email);
			session.setAttribute("nickname", (String)nickname.get("nickname"));
			return "/findchannel";
		}
		return "/intro";
	}
	
	@RequestMapping(value="/logout")
	public String logOut(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}
	
}
