package egovframework.mumukgang.cmmn.web.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.mumukgang.cmmn.web.mapper.MemberMapper;

@Controller
public class IntroController {

	@Resource
	MemberMapper memberMapper;
	@RequestMapping(value="/intro")
	public String viewhome() {
		return "Intro";
	}
	
	@RequestMapping(value ="/menupick/{idx}")
	public String viewMenuPick(@PathVariable("idx") int idx ) {
		System.out.println("idx = " +idx);
		return "menu/MenuPick";
	}
	
	
	/**
	 * 마이페이지 이전 확인
	 *
	 */
	@RequestMapping(value="/confirmmypage")
	public String viewConfirm() {
		return "member/Confirm";
	}
	
	
	/**
	 * 마이페이지 접근시 비밀번호 확인
	 * 
	 */
	@PostMapping(value="/mypagegate")
	@ResponseBody
	public Object confirmMyPage(@RequestParam HashMap<String, Object> param, HttpSession session, Model model) {
		
		String loginid = (String) session.getAttribute("email");
		param.put("email", loginid);
		
		HashMap<String, Object> retVal = new HashMap<String, Object>();
		
		if (memberMapper.loginCheck(param) > 0) {
			retVal.put("code", "OK");
			session.setAttribute("mypage", true);
		} else {
			retVal.put("code", "NO");
			retVal.put("message", "비밀번호가 일치하지 않습니다.");
		}
		
		return retVal;
	}
	
	/**
	 * 마이페이지
	 * 
	 */
	@RequestMapping(value="/mypage")
	public String viewMyPage(HttpSession session, Model model) {
		boolean confirm = (boolean) session.getAttribute("mypage");
		
		if (confirm) {
			String loginid = (String) session.getAttribute("email");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("email", loginid);
			model.addAttribute("info", memberMapper.selectUserInfo(map));
			session.setAttribute("mypage", false);
			return "member/MyPage";
		} else {
			return "channel/authorityrefuse";
		}
	}
}
