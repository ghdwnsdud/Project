package com.lol.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("Login")
@Data
public class Member {

	private String m_id;
}