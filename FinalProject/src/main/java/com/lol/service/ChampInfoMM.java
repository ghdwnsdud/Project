package com.lol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lol.bean.Champ;
import com.lol.bean.Champlst;
import com.lol.dao.Iloldao;

@Service
public class ChampInfoMM {

	@Autowired
	private Iloldao idao;
	
	ModelAndView mav;

	// 챔피언정보
	public ModelAndView getchampInfo(Champlst cl) throws JsonProcessingException {
		mav = new ModelAndView();
		
		// 챔피언 영문명, 한글, 코드 어떠한 값이 넘어오냐에 따라 알아서 SELECT 할 수 있음.
		// 챔피언정보에 필요한 모든 데이터를 가지고 옴.
		if(cl.getChamp_code() != 0) {
			cl = idao.getChampInfo(cl.getChamp_code());
		}else {
			if("".equals(cl.getChampionname()) || cl.getChampionname() == null) {
				cl = idao.getChampnameinfo(cl.getChampname());
			}else{
				cl = idao.getChampionnameinfo(cl.getChampionname());
			}
		}
	
		ObjectMapper mapper = new ObjectMapper();
		String jackson = mapper.writeValueAsString(cl);
		String view = "champinfo";
		mav.addObject("champinfo",jackson);
		mav.setViewName(view);
		return mav;
	}

	// 자동완성을 위한 챔피언리스트 가져오기.
	public ModelAndView champlst() throws JsonProcessingException {
		mav = new ModelAndView();
		
		List<Champ> clist = null;
		
		clist = idao.getChampLst();
		ObjectMapper mapper = new ObjectMapper();
		String jackson = mapper.writeValueAsString(clist);
		String view = "main";
		mav.addObject("champ",jackson);
		mav.setViewName(view);
		return mav;
	}
	
	// 칼바람분석에서 쓰이는 챔피언 리스트와 티어 리스트 가져오기
	public ModelAndView aram() throws JsonProcessingException {
		mav = new ModelAndView();
		
		List<Champlst> clist = null;
		clist = idao.getChampionlist();
		
		List<Champlst> tlist = null;
		tlist = idao.getChampionTierlist();
		
		ObjectMapper mapper = new ObjectMapper();
		String jackson = mapper.writeValueAsString(clist);
		String jackson2 = mapper.writeValueAsString(tlist);
		
		String view = "aram";
		mav.addObject("champlst",jackson);
		mav.addObject("champtierlst",jackson2);
		mav.setViewName(view);
		
		return mav;
	}

	// 로그인 페이지
	public ModelAndView login() {
		mav = new ModelAndView();
		String view = "login";
		mav.setViewName(view);
		
		return mav;
	}

}
