package com.lol.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("Thumb")
@Data
@Accessors(chain=true)
public class Thumb {
		
	
	public Thumb(int t_num, String t_id) {
		super();
		this.t_num = t_num;
		this.t_id = t_id;
		
	}
	
	private int t_num; // 추천한 게시글
	private String t_id; // 추천한 사람
		
	

}
