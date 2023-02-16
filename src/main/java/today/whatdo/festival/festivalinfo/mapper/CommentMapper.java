package today.whatdo.festival.festivalinfo.mapper;

import java.util.List;

import today.whatdo.festival.festivalinfo.vo.commentInfo.CommentVO;

public interface CommentMapper {

	//댓글 갯수
	int commentCount();
	//댓글 리스트
	List<CommentVO> commentList(CommentVO vo);
	//댓글 작성
	int commentInsert(CommentVO vo);
	//댓글 수정
	int commentUpdate(CommentVO vo);
	//댓글 삭제
	int commentDelete(int ciNum);
	
}
