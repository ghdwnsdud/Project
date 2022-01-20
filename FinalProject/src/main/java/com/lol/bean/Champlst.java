package com.lol.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("Champlst")
@Data
public class Champlst {
	
	private int champ_code;
	private String champname;
	private String championname;
	private String champ_img;
	
	private String rune_img_one;
	private String rune_img_two;
	
	private String spell_img;
	private String starting_item_img_one;
	private String starting_item_img_two;
	
	private String main_item_build_img;
	private String boots_img;
	
	private String skill_img;
	private String skill_key;
	private String synergy_tier;
	private String combination_score;
	private String k_synergy;
	
	private String pick;
	private String win;
	private String kda;
	private String tier;
	private String position;


}
