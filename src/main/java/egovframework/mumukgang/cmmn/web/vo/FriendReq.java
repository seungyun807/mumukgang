package egovframework.mumukgang.cmmn.web.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class FriendReq {
	private String relation_ID;
	private String req_email;
	private String req_nickname;
	private String res_email;
	private String res_nickname;
}
