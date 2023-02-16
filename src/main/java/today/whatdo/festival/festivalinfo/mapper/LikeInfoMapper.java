package today.whatdo.festival.festivalinfo.mapper;


import org.apache.ibatis.annotations.Mapper;
import today.whatdo.festival.festivalinfo.vo.likeInfo.LikeInfoVO;

@Mapper
public interface LikeInfoMapper {
	
	LikeInfoVO likeCheck(LikeInfoVO vo);
	
	void insertLike(LikeInfoVO vo);
	
	void deleteLike(LikeInfoVO vo);
	
	int getLikeCountByFiNum(int fiNum);
	
	LikeInfoVO getLikeState(LikeInfoVO vo);
}
