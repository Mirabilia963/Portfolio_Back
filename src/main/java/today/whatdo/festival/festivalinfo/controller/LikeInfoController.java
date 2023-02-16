package today.whatdo.festival.festivalinfo.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import today.whatdo.festival.festivalinfo.mapper.LikeInfoMapper;
import today.whatdo.festival.festivalinfo.service.LikeInfoService;
import today.whatdo.festival.festivalinfo.vo.likeInfo.LikeInfoVO;
import today.whatdo.festival.userinfo.vo.UserInfoVO;

import javax.servlet.http.HttpSession;


@Controller
@RequiredArgsConstructor
@RequestMapping("/festival/like")
public class LikeInfoController {


	// 좋아요에 대한 상태를 수정하는거니까

	// 호출에 대한 실패도 가능성을 열어두고 구현

	@Autowired
	private LikeInfoService likeInfoService;

	@PutMapping(value = "/{fiNum}", produces = "text/plain")
	public ResponseEntity handleLikeState(@PathVariable("fiNum") int fiNum, HttpSession session) {


		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");

		if (userInfo == null) {
			return ResponseEntity.badRequest().body("NO SESSION");
		}

		LikeInfoVO search = new LikeInfoVO();
		search.setUiNum(userInfo.getUiNum());
		search.setFiNum(fiNum);

		try {
			String resMsg;
			LikeInfoVO likeCheck = likeInfoService.likeCheck(search); // 좋아요 상태 불러오기

			if (likeCheck == null) { // 좋아요상태가  아님
				// 좋아요 insert
				likeInfoService.insertLike(search);
				resMsg = "INSERT";
			} else {
				// 좋아요가 체크되어있다면 delete
				likeInfoService.deleteLike(search);
				resMsg = "DELETE";
			}


			return ResponseEntity.ok().body(resMsg);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body("FAILED");
		}
	}

	@GetMapping("/count/{fiNum}")
	public ResponseEntity getLikeCount(@PathVariable("fiNum") int fiNum) {


		try {

			int likeCount = likeInfoService.getLikeCountByFiNum(fiNum);
			return ResponseEntity.ok(likeCount);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body("FAILED");
		}
	}

	@GetMapping("/state/{fiNum}")
	public ResponseEntity getLikeState(@PathVariable("fiNum") int fiNum, HttpSession session) {

		UserInfoVO userInfo = (UserInfoVO) session.getAttribute("userInfo");

		String msg;
		
		if (userInfo == null) {
			msg = "UN_ACTIVE";
			return ResponseEntity.ok().body(msg);
		}

		LikeInfoVO search = new LikeInfoVO();
		search.setUiNum(userInfo.getUiNum());
		search.setFiNum(fiNum);


		try {

			LikeInfoVO state = likeInfoService.getLikeState(search);

			if (state == null) {
				msg = "UN_ACTIVE";
			} else {
				msg = "ACTIVE";
			}
			
			
			return ResponseEntity.ok(msg);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body("FAILED");
		}

	}


}
