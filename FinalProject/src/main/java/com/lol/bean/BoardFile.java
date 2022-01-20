package com.lol.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("BoardFile")
@Data
@Accessors(chain=true)
public class BoardFile {
	
	private int bf_num; //pk
	private int bf_bnum; //fk
	private String bf_oriName;
	private String bf_sysName;
	
}
