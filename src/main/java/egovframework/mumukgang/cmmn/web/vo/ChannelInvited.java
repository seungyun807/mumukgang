package egovframework.mumukgang.cmmn.web.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChannelInvited{
	private int ch_num;
	private String ch_name;
	private String res_email;
	private String req_email;
	private String nickname;
	private String request_time;
}