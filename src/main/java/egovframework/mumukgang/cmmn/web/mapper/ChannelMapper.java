package egovframework.mumukgang.cmmn.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.codegen.ObjCTarget;

import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import egovframework.mumukgang.cmmn.web.vo.Friends;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface ChannelMapper {
	public int createchannel(Channel channel);
	
	public void channelmember(ChannelMember channelmember);
	
	public int authoritychannel(ChannelMember channelmember);
	
	public List<HashMap<String, Object>> participatingch(HashMap<String, Object> map);
	
	public HashMap<String, Object> selectchname(HashMap<String, Object> map);
}
