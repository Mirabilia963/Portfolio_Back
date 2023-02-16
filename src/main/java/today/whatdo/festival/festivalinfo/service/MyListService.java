package today.whatdo.festival.festivalinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import today.whatdo.festival.festivalinfo.mapper.MyListMapper;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;
import today.whatdo.festival.festivalinfo.vo.mylist.MyListVO;

@Service
public class MyListService {
	
	@Autowired
	private MyListMapper myListMapper;
	
	//마이리스트 전부 불러오기
	public List<FestivalInformationVO> getMyLists(MyListVO myList){
		return myListMapper.selectMyLists(myList);
	}
	
	//마이리스트 추가
	public int insertMyList(MyListVO myList) {
		return myListMapper.insertMyList(myList);
	}
	
	//마이리스트 삭제
	public int deleteMyList(int fiNum) {
		return myListMapper.deleteMyList(fiNum);
	}
	
	//마이리스트 선택 삭제
	public int deleteMyLists(List<Integer> mlNums) {
		return myListMapper.deleteMyLists(mlNums);
	}
}
