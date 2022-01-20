package com.lol.bean;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("Board")
@Data
@Accessors(chain=true)
public class Board { // BLIST VIEW

	private int b_num;
	private String b_title;
	private String b_contents;
	private String b_id;
	private Timestamp b_date;	//"년월일 시분초"
	private int b_views;
	private int b_thumbs;
}
