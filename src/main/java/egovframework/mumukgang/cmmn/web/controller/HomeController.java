package egovframework.mumukgang.cmmn.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping(value="/home")
	public String viewHome() {
		return "home/Home";
	}
	
	@RequestMapping(value="/friendslist")
	public String viewFriendsList(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendemail", "caleb@naver.com");
		model.addAttribute("friendslist", map);
		return "home/friendslist";
	}
	

}
