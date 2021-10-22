package egovframework.mumukgang.cmmn.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroController {

	@RequestMapping(value="/intro")
	public String viewhome() {
		return "Intro";
	}
	
	@RequestMapping(value ="/menupick/{idx}")
	public String viewMenuPick(@PathVariable("idx") int idx ) {
		System.out.println("idx = " +idx);
		return "menu/MenuPick";
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
