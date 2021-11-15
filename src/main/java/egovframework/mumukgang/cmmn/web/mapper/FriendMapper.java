package egovframework.mumukgang.cmmn.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.codegen.ObjCTarget;

import egovframework.mumukgang.cmmn.web.vo.FriendReq;
import egovframework.mumukgang.cmmn.web.vo.Friends;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface FriendMapper {
	
	public HashMap<String, Object> findfriendsnickname(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> friendslist(HashMap<String, Object> map);
	
	public int requestfriends(HashMap<String, Object> map);
	
	public List<Map<String, Object>> receivedfriendrequest(HashMap<String, Object> map);
	
	public HashMap<String, Object> selectnickname(HashMap<String, Object> map);
	
	public List<Map<String, Object>> requestfriendslist(HashMap<String, Object> map);
	
	public void acceptfriends(Map<String, Object> map);
	
	public int addtofriends(FriendReq friendReq);
	
	public int addtofriends2(FriendReq friendReq);
	
	public int finddupfriends(HashMap<String, Object> map);
	
	public void delfriend(HashMap<String, Object> map);
	
	public int selectfriendrequest(HashMap<String, Object> map);
}
