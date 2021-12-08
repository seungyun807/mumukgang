package egovframework.mumukgang.cmmn.web.chat.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Chat{ //implements Serializable {
	//private int no;
	private int roomNo;
	private String memberId;
	private String pickid;
	private String ispick;
	private String chatContent;
	private String agree;
	private List<String> result;
	private Date sendDate;
	private boolean empty;
	private boolean del;
	private boolean out;
	
	//private String vaildYN;
}
