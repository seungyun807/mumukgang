package egovframework.mumukgang.cmmn.web.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MenuMapper {
	
	public List<HashMap<String, Object>> jjim();
	
	public List<HashMap<String, Object>> guktang();
	
	public List<HashMap<String, Object>> jjigae();
	
	public List<HashMap<String, Object>> myeon();
	
	public List<HashMap<String, Object>> haejang();
	
	public List<HashMap<String, Object>> selectJapanese();
	
	public List<HashMap<String, Object>> selectChinese();
	
	public List<HashMap<String, Object>> selectAsianWestern();
	
	public List<HashMap<String, Object>> selectConvenience();
	
	public List<HashMap<String, Object>> selectFastFood();
	
	public List<HashMap<String, Object>> selectBunsick();
	
	public List<HashMap<String, Object>> selectDessert();

	public List<HashMap<String, Object>> dessertbrand();
	
	public void menupick (HashMap<String, Object> map);
	
	public void delmenupick (HashMap<String, Object> map);
	
	public int selcountmenupick (HashMap<String, Object> map);
	
	public List<String> selmenupick (int ch_num);
	
	public void delchmenu (HashMap<String, Object> map);
		
}