package today.whatdo.festival.festivalinfo.api;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ApiCall {
	@Autowired
	private RestTemplate restTemplate;

	public <T> T getDataToAPI(String url, Class<T> clazz) {
		try {
			URI uri = new URI(url);
			ResponseEntity<T> response = restTemplate.getForEntity(uri, clazz);
			return response.getBody();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
