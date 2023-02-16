package today.whatdo.festival.festivalinfo.vo.mylist;

import java.util.List;

import lombok.Data;

@Data
public class MyListVO {
	
	private int mlNum;
	private String mlDate;
	private int uiNum;
	private int fiNum;
	private List<Integer> mlNums;
}
