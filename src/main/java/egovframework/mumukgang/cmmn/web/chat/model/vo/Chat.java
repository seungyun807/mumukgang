package egovframework.mumukgang.cmmn.web.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Chat{ //implements Serializable {
	//private int no;
	private String memberId;
	private String pickid;
	private String ispick;
	private String chatContent;
	private String agree;
	private String result;
	private Date sendDate;
	private boolean empty;
	
	
	//private String vaildYN;
}
