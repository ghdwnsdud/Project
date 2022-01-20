package com.lol.bean;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("Reply")
@Data
@Accessors(chain=true)
public class Reply {
	
	private int r_bnum; //원글 번호
	private int r_num; // pk, 댓글 번호
	private String r_contents;
	private String r_id;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
	private Timestamp r_date;
	
	
}
