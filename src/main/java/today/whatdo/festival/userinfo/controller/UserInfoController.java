package today.whatdo.festival.userinfo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import today.whatdo.festival.userinfo.service.UserInfoService;
import today.whatdo.festival.userinfo.vo.UserInfoVO;

@Controller
@Slf4j
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;

	@GetMapping("/user-infos")
	public String getUserInfos(Model model, UserInfoVO userInfo) {
		log.info("userInfo=>{}", userInfo);
		model.addAttribute("userList", userInfoService.getUserInfos(userInfo));
		return "views/user-info/list";
	}
	
	@GetMapping("/user-infos/check/{uiId}")
	@ResponseBody
	public boolean existsUserId(@PathVariable("uiId") String uiId) {
		return userInfoService.existsUserId(uiId);
	}

	@GetMapping("/user-infos/check-nickname/{uiNickname}")
	@ResponseBody
	public boolean existsUserNickname(@PathVariable("uiNickname") String uiNickname) {
		return userInfoService.existsUserNickname(uiNickname);
	}

	@PostMapping("/user-infos")
	public @ResponseBody int addUserInfo(@RequestBody UserInfoVO userInfo) {
		return userInfoService.insertUserInfo(userInfo);
	}

	@PostMapping("/user-infos/{uiNum}")
	public @ResponseBody boolean checkPassword(@RequestBody UserInfoVO userInfo, @PathVariable("uiNum") int uiNum) {
		return userInfoService.checkPassword(userInfo, uiNum);
	}

	@PatchMapping("/user-infos/{uiNum}")
	public @ResponseBody boolean modifyUserInfo(@RequestBody UserInfoVO userInfo, @PathVariable("uiNum") int uiNum,
			HttpSession session) {
		UserInfoVO sessionUserInfo = (UserInfoVO) session.getAttribute("userInfo");
		if (sessionUserInfo == null || sessionUserInfo.getUiNum() != uiNum) {
			throw new RuntimeException("잘못된 정보 수정 입니다.");
		}
		userInfo.setUiNum(uiNum);
		return userInfoService.updateUserInfo(userInfo, session);
	}

	@DeleteMapping("/user-infos/{uiNum}")
	public @ResponseBody boolean removeUserInfo(@RequestBody UserInfoVO userInfo, @PathVariable("uiNum") int uiNum) {
		return userInfoService.removeUserInfo(userInfo, uiNum);
	}
	
}
