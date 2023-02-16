package today.whatdo.festival.festivalinfo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;
import today.whatdo.festival.festivalinfo.vo.mylist.MyListVO;

public interface MyListMapper {
	
	//마이리스트 전부 불러오기
	List<FestivalInformationVO> selectMyLists(MyListVO myList);
	//마이리스트 추가
	int insertMyList(MyListVO myList);
	//마이리스트 삭제
	int deleteMyList(int fiNum);
	//마이리스트 선택 삭제
	int deleteMyLists(@Param("mlNums") List<Integer> mlNums);
}
