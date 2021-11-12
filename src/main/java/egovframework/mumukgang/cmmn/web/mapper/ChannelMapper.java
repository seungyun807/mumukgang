package egovframework.mumukgang.cmmn.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.codegen.ObjCTarget;

import egovframework.mumukgang.cmmn.web.vo.Channel;
import egovframework.mumukgang.cmmn.web.vo.ChannelInvited;
import egovframework.mumukgang.cmmn.web.vo.ChannelMember;
import egovframework.mumukgang.cmmn.web.vo.Chnum;
import egovframework.mumukgang.cmmn.web.vo.Food;
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
	
	public HashMap<String, Object> selectchtype(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> chhost (HashMap<String, Object> map);
	
	public List<Food> selectfood ();
	
	public int countchmem (int roomNo);
	
	public int delauthority (HashMap<String, Object> map);
	
	public void delchannel (HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> findpublicch();
	
	public int ispublicch (ChannelMember channelmember);
	
	public  List<HashMap<String, Object>> searchpublicch (String keyword);
	
	public  List<HashMap<String, Object>> searchpublicchregion (String ch_region);
	
	public  List<HashMap<String, Object>> searchpublicchwithregion (HashMap<String, Object> map);
	
	public void channelinvited(ChannelInvited channelInvited);
	
	public List<ChannelInvited> selectchinvited(String email);
	
	public void deleteinvited(ChannelMember channelmember);
}
