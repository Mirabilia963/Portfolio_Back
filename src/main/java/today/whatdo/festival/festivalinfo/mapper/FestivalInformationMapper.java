package today.whatdo.festival.festivalinfo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.SearchParameterVO;

@Mapper
public interface FestivalInformationMapper {
	int insertFestivalInformations(@Param("festivalInfoList") List<FestivalInformationVO> festivalInfoList);

	int insertFestivalInformation(FestivalInformationVO festivalInfo);
	
	FestivalInformationVO selectFestivalInformation(String contentId);
	
	FestivalInformationVO selectFestivalInformationByNum(int fiNum);
	
	int updateFestivalInformation(FestivalInformationVO festivalInfo);
	
	List<FestivalInformationVO> selectFestivalInformationLists(SearchParameterVO searchParameter);
	
	//메인 페이지 조회수 높은 축제 정보 10개 불러오기
	List<FestivalInformationVO> selectFestivalInformationByReadcount(FestivalInformationVO festivalInfo);

	List<FestivalInformationVO> selectFinishedInformationLists(SearchParameterVO searchParameter);

	List<FestivalInformationVO> selectMostLikedfestivalLists(SearchParameterVO searchParameter);
	
	List<FestivalInformationVO> selectFestivalInformationBySearch(SearchParameterVO searchParameter);
}
