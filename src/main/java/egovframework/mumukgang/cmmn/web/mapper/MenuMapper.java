package egovframework.mumukgang.cmmn.web.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MenuMapper {
	
	public List<HashMap<String, Object>> selectKorean();
	
	public List<HashMap<String, Object>> selectJapanese();
	
	public List<HashMap<String, Object>> selectChinese();
	
	public List<HashMap<String, Object>> selectAsianWestern();
	
	public List<HashMap<String, Object>> selectConvenience();
	
	public List<HashMap<String, Object>> selectFastFood();
	
	public List<HashMap<String, Object>> selectBunsick();


		
}