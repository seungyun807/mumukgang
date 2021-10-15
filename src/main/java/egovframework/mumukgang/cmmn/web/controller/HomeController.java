package egovframework.mumukgang.cmmn.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping(value="/home")
	public String viewhome() {
		return "home";
	}
	
	@RequestMapping(value ="/menupick/{idx}")
	public String viewMenuPick(@PathVariable("idx") int idx ) {
		System.out.println("idx = " +idx);
		return "menu/MenuPick";
	}
	
	@RequestMapping(value="/echo")
	public String viewEcho() {
		return "echo-ws";
	}
	//@RequestMapping(value="/chat/{idx}")
	//public String viewChat(@PathVariable("idx") int idx, Model model) {
	//	System.out.println("idx = " +idx);
	//	model.addAttribute("idx", idx);
	//	return "chat-ws";
	//}


//	@RequestMapping(value="/chat")
//	public String viewChat() {
//		return "chat-ws";
//	}
}
