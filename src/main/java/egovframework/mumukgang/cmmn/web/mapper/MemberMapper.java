package egovframework.mumukgang.cmmn.web.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.mumukgang.cmmn.web.vo.Friends;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MemberMapper {


	public int UserIdCheck(String email);
	
	public void UserJoin(HashMap<String, Object> map);
	
	public int loginCheck(HashMap<String, Object> map);
	
	public HashMap<String, Object> findfriendsemail(HashMap<String, Object> map);
	
	public HashMap<String, Object> findfriendsnickname(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> friendslist(HashMap<String, Object> map);
	
	public void requestfriends(HashMap<String, Object> map);
	
	public HashMap<String, Object> receivedfriendrequest(HashMap<String, Object> map);
}
