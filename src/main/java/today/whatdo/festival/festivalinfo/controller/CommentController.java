package today.whatdo.festival.festivalinfo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import today.whatdo.festival.festivalinfo.service.CommentService;
import today.whatdo.festival.festivalinfo.vo.commentInfo.CommentVO;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping("/list") //댓글 리스트
	@ResponseBody
	private List<CommentVO> commentServiceList(Model model) throws Exception{
		return commentService.commentList(null);
	}
	
	@RequestMapping("/insert") //댓글 작성
	@ResponseBody
	private int commentServiceInsert(@RequestParam int fiNum, @RequestParam String ciContent) throws Exception{
		CommentVO comment = new CommentVO();
		comment.setFiNum(fiNum);
		comment.setCiContent(ciContent);
		comment.setCiWriter("익명");
		
		return commentService.commentInsert(comment);
	}
	
	@RequestMapping("/update") //댓글 수정
	@ResponseBody
	private int commentServiceUpdateProc(@RequestParam int ciNum, @RequestParam String ciContent) throws Exception{
		CommentVO comment = new CommentVO();
		comment.setCiNum(ciNum);
		comment.setCiContent(ciContent);
		
		return commentService.commentUpdate(comment);
	}
	
	@RequestMapping("/delete/{ciNum}") //댓글 삭제
	@ResponseBody
	private int commentServiceDelete(@PathVariable int ciNum) throws Exception{
		
		return commentService.commentDelete(ciNum);
	}
	

	

}
