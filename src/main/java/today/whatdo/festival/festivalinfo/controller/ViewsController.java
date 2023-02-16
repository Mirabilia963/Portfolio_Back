package today.whatdo.festival.festivalinfo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewsController {

	@GetMapping("/")
	public String Home() {
		return "views/index";
	}
	
	//session값이 없으면 로그인 페이지로 보내기
	@GetMapping("/views/**")
	public String goPage(HttpServletRequest request) {
		String uri = request.getRequestURI();
		return uri.substring(1);
	}
	
}
