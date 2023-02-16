package today.whatdo.festival.festivalinfo.vo.festivalInfo;

import java.util.List;

import lombok.Data;

@Data
public class FestivalResponseVO {
	private FestivalInformationVO festivalInfo;
	private List<FestivalInformationVO> locationInfo;
	private List<FestivalInformationVO> festivalImages;
	private FestivalInformationVO festivalIntro;
}
