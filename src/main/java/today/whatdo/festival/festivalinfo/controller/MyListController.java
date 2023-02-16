package today.whatdo.festival.festivalinfo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import today.whatdo.festival.festivalinfo.service.CheckSessionUserInfo;
import today.whatdo.festival.festivalinfo.service.MyListService;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;
import today.whatdo.festival.festivalinfo.vo.mylist.MyListVO;

@Controller
@Slf4j
public class MyListController {
	
	@Autowired
	private MyListService myListService;
	
	//로그인이 돼있는 상태인지 체크
	@Autowired
	private CheckSessionUserInfo checkSessionUserInfo;
	
	//마이리스트 전부 불러오기
	@GetMapping("/my-lists")
	@ResponseBody
	public List<FestivalInformationVO> getMyLists(@ModelAttribute MyListVO myList, Model model, HttpSession session){
		checkSessionUserInfo.checkSession(myList, session);
		return myListService.getMyLists(myList);
	}
	
	//마이리스트 추가
	@PostMapping("/my-lists")
	@ResponseBody
	public int insertMyList(@RequestBody MyListVO myList, HttpSession session) {
		checkSessionUserInfo.checkSession(myList, session);
		return myListService.insertMyList(myList);
	}
	
	//마이리스트 삭제
	@DeleteMapping("/my-lists/{fiNum}")
	@ResponseBody
	public int deleteMyList(@PathVariable("fiNum") int fiNum, HttpSession session) {
		MyListVO myList = new MyListVO();
		checkSessionUserInfo.checkSession(myList, session);
		return myListService.deleteMyList(fiNum);
	}
	
	//마이리스트 선택 삭제
	@DeleteMapping("/my-lists")
	@ResponseBody
	public int deleteMyLists(@RequestBody MyListVO myList, HttpSession session) {
		checkSessionUserInfo.checkSession(myList, session);
		return myListService.deleteMyLists(myList.getMlNums());
	}
	
}
