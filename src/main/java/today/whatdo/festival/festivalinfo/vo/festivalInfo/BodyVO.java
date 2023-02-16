package today.whatdo.festival.festivalinfo.vo.festivalInfo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class BodyVO {
	private ItemsVO items;
	private int numOfRows;
	private int PageNo;
	private int totalCount;
}
