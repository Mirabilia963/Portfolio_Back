package today.whatdo.festival.festivalinfo.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;

@Component
@PropertySource("classpath:env.properties")
public class ApiDetailFestivalInfo {
	@Value("${datago.url}")
	private String dataUrl;
	@Value("${festival.api.key}")
	private String festivalKey;
	@Autowired
	private DatagoApiConnect datagoApiConnect;

	public FestivalInformationVO getFestivalInformationDetail(FestivalInformationVO festivalInfo) {
		String url = dataUrl + "/detailCommon?";
		url += "contentTypeId=15&_type=json&MobileOS=ETC&MobileApp=APPTest&overviewYN=Y&defaultYN=Y&serviceKey=";
		url += festivalKey + "&contentId=" + festivalInfo.getContentid();
		List<FestivalInformationVO> result = datagoApiConnect.datagoApi(url);
		return !result.isEmpty() ? result.get(0) : null;
	}

	public List<FestivalInformationVO> getFestivalImages(FestivalInformationVO festivalInfo) {
		String url = dataUrl + "/detailImage?";
		url += "_type=json&MobileOS=ETC&MobileApp=APPTest&subImageYN=Y&serviceKey=";
		url += festivalKey + "&contentId=" + festivalInfo.getContentid();
		return datagoApiConnect.datagoApi(url);
	}

	public List<FestivalInformationVO> getLocationInformationByMap(FestivalInformationVO festivalInfo) {
		String url = dataUrl + "/locationBasedList?";
		url += "radius=5000&contentTypeId=12&arrange=E&numOfRows=10&_type=json&MobileOS=ETC&MobileApp=APPTest&serviceKey=";
		url += festivalKey + "&mapX=" + festivalInfo.getMapx() + "&mapY=" + festivalInfo.getMapy();
		return datagoApiConnect.datagoApi(url);
	}
	public FestivalInformationVO getFestivalIntro(FestivalInformationVO festivalInfo) {
		String url = dataUrl + "/detailIntro?";
		url += "contentTypeId=15&numOfRows=1&_type=json&MobileOS=ETC&MobileApp=APPTest&serviceKey=";
		url += festivalKey + "&contentId=" + festivalInfo.getContentid();
		List<FestivalInformationVO> result = datagoApiConnect.datagoApi(url);
		return !result.isEmpty() ? result.get(0) : null;
	}
}
