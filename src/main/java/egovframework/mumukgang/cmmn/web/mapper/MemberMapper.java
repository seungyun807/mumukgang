package egovframework.mumukgang.cmmn.web.mapper;

import java.util.HashMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MemberMapper {

	public int UserIdCheck(String email);
	
	public void UserJoin(HashMap<String, Object> map);
	
	public int loginCheck(HashMap<String, Object> map);
}
