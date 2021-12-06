package egovframework.mumukgang.cmmn.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.codegen.ObjCTarget;
import org.apache.commons.validator.routines.checkdigit.VerhoeffCheckDigit;

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
	
	public List<HashMap<String, Object>> findpublicch(int curPage);
	
	public int findpublicchCnt();
	
	public int ispublicch (ChannelMember channelmember);
	
	public  List<HashMap<String, Object>> searchpublicch (HashMap<String, Object> map);
	
	public  int searchpublicchCnt (String keyword);
	
	public int searchpublicchregionCnt (String ch_region);
	
	public  List<HashMap<String, Object>> searchpublicchregion (HashMap<String, Object> map);
	
	public  int searchpublicchwithregionCnt (HashMap<String, Object> map);
	
	public  List<HashMap<String, Object>> searchpublicchwithregion (HashMap<String, Object> map);
	
	public void channelinvited(ChannelInvited channelInvited);
	
	public List<ChannelInvited> selectchinvited(String email);
	
	public void deleteinvited(ChannelMember channelmember);
	
	public HashMap<String, Object> selectchinfo (int ch_num);
	
	public List<String> selectchmember (int ch_num);
	
	public void updatech (Channel channel);
	
	public void updatedelchmember (ChannelMember channelMember);
	
	public List<HashMap<String, Object>> findmycop (HashMap<String, Object> map);
	
	public int findmycopCnt (String email);
	
	public void saveChat(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> selectChat(int ch_num);
}
