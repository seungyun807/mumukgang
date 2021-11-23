package egovframework.mumukgang.cmmn.web.mapper;

import java.util.HashMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MemberMapper {
	
	public int UserIdCheck(String email);
	
	public int UserJoin(HashMap<String, Object> map);
	
	public int loginCheck(HashMap<String, Object> map);
	
	public int UserNickCheck(String nickname);
	
	public HashMap<String, Object> selectEandNick(HashMap<String, Object> map);
	
	public HashMap<String, Object> selectUserInfo(HashMap<String, Object> map);
}
