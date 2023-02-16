package today.whatdo.festival.festivalinfo.vo.festivalInfo;

import lombok.Data;

@Data
public class SearchParameterVO {
	private String fesMonth;
	private String fesLocal;
	private String fesTitle;
	private int page;
	private int rows;
}
