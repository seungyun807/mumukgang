package egovframework.mumukgang.cmmn.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.codegen.ObjCTarget;

import egovframework.mumukgang.cmmn.web.vo.Friends;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MemberMapper {


	public int UserIdCheck(String email);
	
	public int UserJoin(HashMap<String, Object> map);
	
	public int loginCheck(HashMap<String, Object> map);
	
	public HashMap<String, Object> findfriendsemail(HashMap<String, Object> map);
	
	public HashMap<String, Object> findfriendsnickname(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> friendslist(HashMap<String, Object> map);
	
	public int requestfriends(HashMap<String, Object> map);
	
	public List<Map<String, Object>> receivedfriendrequest(HashMap<String, Object> map);
	
	public HashMap<String, Object> selectnickname(HashMap<String, Object> map);
	
	public int UserNickCheck(String nickname);
	
	public void acceptfriends(HashMap<String, Object> map);
	
	public int addtofriends(HashMap<String, Object> map);
	
	public int addtofriends2(HashMap<String, Object> map);
	
	public int finddupfriends(HashMap<String, Object> map);
	
	public void delfriend(HashMap<String, Object> map);
	
	public int selectfriendrequest(HashMap<String, Object> map);
}
