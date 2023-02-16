package today.whatdo.festival.festivalinfo.api;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalInformationVO;
import today.whatdo.festival.festivalinfo.vo.festivalInfo.FestivalResultVO;

@Component
@Slf4j
public class DatagoApiConnect {
	@Autowired
	private RestTemplate restTemplate;
	@Autowired
	private ObjectMapper om;

	public List<FestivalInformationVO> datagoApi(String url) {
		try {
			URI uri = new URI(url);
			ResponseEntity<Map> getResult = restTemplate.getForEntity(uri, Map.class);
			if(getResult.getBody()!=null) {
				int numOfRows = (int) ((Map<String, Object>) ((Map<String, Object>) getResult.getBody().get("response")).get("body")).get("numOfRows");
				if (numOfRows == 0) {
					return new ArrayList<>();
				}
				FestivalResultVO result = om.convertValue(getResult.getBody(), FestivalResultVO.class);
				if (result != null) {
					return result.getResponse().getBody().getItems().getItem();
				}
			}
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}
}
