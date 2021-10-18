package egovframework.mumukgang.cmmn.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@RequestMapping(value="/join")
	public String viewhome() {
		return "member/Join";
	}
}
