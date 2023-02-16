package today.whatdo.festival.festivalinfo.schedule;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import today.whatdo.festival.festivalinfo.api.ApiCall;
import today.whatdo.festival.festivalinfo.service.FestivalInformationService;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalResultVO;

@Component
@Slf4j
@PropertySource("classpath:env.properties")
public class ApiScheduler {

	@Scheduled(cron = "0 0 0/24 * * *")
	public void test() {
		log.debug("schdule test");
	}

	@Autowired
	private FestivalInformationService festivalInformationService;
	@Autowired
	private ApiCall apiFestivalInfo;
	@Value("${datago.url}")
	private String dataUrl;
	@Value("${festival.update.period}")
	private int updateDate;
	@Value("${festival.api.key}")
	private String festivalKey;

	// 매일 0시 0분 0초에 축제데이터를 받아오는 것
	// Url로 축제 api로 접근해 받아온 정보를 FestivalInformationService를 통해 업데이트
	@Scheduled(cron = "0 0 0 * * *")
	public void dailyFestivalInformation() {
		String searchUrl = "/searchFestival?numOfRows=1000&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A";
		searchUrl += "&serviceKey="+festivalKey;
		Date date = Date.from(Instant.now().plus(Duration.ofDays(updateDate))); // 지금 날짜로부터 updateDate 일만큼 추가
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		searchUrl += "&eventStartDate="+sdf.format(date);	// 해당 api에서 요구하는 형식으로 변형
		int result = festivalInformationService.dailyUpdateFestivalInformation(
				apiFestivalInfo.getDataToAPI(dataUrl + searchUrl, FestivalResultVO.class));
		log.debug("result=>{}", result);
	}
}
