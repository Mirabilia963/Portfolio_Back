package today.whatdo.festival.userinfo.mapper;

import java.util.List;

import today.whatdo.festival.userinfo.vo.UserInfoVO;

public interface UserInfoMapper {

	List<UserInfoVO> selectUserInfoList(UserInfoVO userInfo);
	UserInfoVO selectUserInfoByKakaoId(String uiId);
	UserInfoVO selectUserInfoByUiId(String uiId);
	UserInfoVO selectUserInfoByNickName(String uiNickname);
	UserInfoVO selectUserInfo(int uiNum);
	UserInfoVO selectUserInfoByIdAndPwd(UserInfoVO userInfo);
	int insertUserInfo(UserInfoVO userInfo);
	int updateUserInfo(UserInfoVO userInfo);
	int deleteUserInfo(int uiNum);
	
}
