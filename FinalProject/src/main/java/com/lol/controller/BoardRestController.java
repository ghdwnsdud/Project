
package com.lol.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lol.bean.Reply;
import com.lol.bean.Thumb;
import com.lol.service.BoardMM;

@RestController

@RequestMapping(value = "/rest")
class BoardRestController {

	@Autowired
	private BoardMM bm;
	
	// 댓글 입력
	@PostMapping(value = "/replyinsert", produces = "application/json;charset=utf-8")
	public List<Reply> replyInsert(@RequestBody Reply r,HttpSession session) {
		r.setR_id(session.getAttribute("m_id").toString());
		List<Reply> rList=bm.replyInsert(r);
		
		return rList;

	}
	
	// 추천
	@PostMapping(value="/addthumbs")
	public int addthumbs(Thumb thumb) {
		System.out.println(thumb.getT_id());
		System.out.println(thumb.getT_num());
		int result;
		result = bm.addThumbs(thumb);
		
		return result;
	}
  
  }
