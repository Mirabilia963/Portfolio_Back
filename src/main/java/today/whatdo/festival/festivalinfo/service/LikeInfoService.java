package today.whatdo.festival.festivalinfo.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import today.whatdo.festival.festivalinfo.mapper.LikeInfoMapper;
import today.whatdo.festival.festivalinfo.vo.likeInfo.LikeInfoVO;

@Service
public class LikeInfoService {
	
	@Autowired
	private LikeInfoMapper mapper;
	
	
	public LikeInfoVO likeCheck(LikeInfoVO vo){
		return mapper.likeCheck(vo);
	}
	
	public void insertLike(LikeInfoVO vo){
		mapper.insertLike(vo);
	}
	
	public void deleteLike(LikeInfoVO vo){
		mapper.deleteLike(vo);
	}
	
	public int getLikeCountByFiNum(int fiNum){
		return mapper.getLikeCountByFiNum(fiNum);
	}
	
	public LikeInfoVO getLikeState(LikeInfoVO vo){
		return mapper.getLikeState(vo);
	}
}
