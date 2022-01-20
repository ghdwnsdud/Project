package com.lol.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("Champ")
@Data
public class Champ {
	
	private String champname;
}
