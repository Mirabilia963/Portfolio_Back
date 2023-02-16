package today.whatdo.festival.userinfo.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class UserInfoVO implements Serializable {
	
	//session scope를 사용하기 위해서 Serializable이 필요하다.
	private static final long serialVersionUID = 1L;
	
	private int uiNum;
	private String uiId;
	private String uiName;
	private String uiNickname;
	private String uiPwd;
	private String uiActive;
	private String uiCredat;
	
}
