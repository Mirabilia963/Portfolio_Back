package today.whatdo.festival.festivalinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import today.whatdo.festival.festivalinfo.mapper.CommentMapper;
import today.whatdo.festival.festivalinfo.vo.commentInfo.CommentVO;

@Service
public class CommentService {

	@Autowired
	private CommentMapper commentMapper;
	
	//댓글 작성
	public int commentInsert(CommentVO vo) {
		return commentMapper.commentInsert(vo);
	}
	
	//댓글 리스트
	public List<CommentVO> commentList(CommentVO vo) {
		return commentMapper.commentList(vo);
	}
	
	//댓글 수정
	public int commentUpdate(CommentVO vo) {
		return commentMapper.commentUpdate(vo);
	}
	
	//댓글 삭제
	public int commentDelete(int ciNum) {
		return commentMapper.commentDelete(ciNum);
		
	}
	
}
