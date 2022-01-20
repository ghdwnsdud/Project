package com.lol.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lol.bean.Board;
import com.lol.service.BoardMM;

@Controller
public class BoardController { // 게시판 관련 컨트롤러

	@Autowired
	private BoardMM bm; // 게시판 서비스 클래스

	ModelAndView mav; // 선택
	
	// 박제게시판
	@RequestMapping(value = "/loginboardhome")
	public ModelAndView loginBoardHome(HttpSession session) {
		mav = bm.loginBoardHome(session, 1); // session과 페이지 번호 1을 넘김.
		return mav;
	}

	// 페이지 이동하는 url
	@RequestMapping(value = "/moveboardpage")
	public ModelAndView moveBoardPage(HttpSession session, int pageNum) {
		mav = bm.loginBoardHome(session, pageNum);
		return mav;
	}

	// 조회수 올리는 함수
	@GetMapping(value = "/contents")
	public ModelAndView getContents(Board board, HttpSession session) {
		String m_id = (String) session.getAttribute("m_id");
		Integer bNum = board.getB_num();
		bm.viewUpdate(bNum);

		mav = bm.getContents(bNum, m_id, session);

		return mav;

	}
	
	// 글쓰기 페이지로 이동
	@GetMapping(value = "writefrm")
	public String writeFrm() {
		return "writeFrm";
	}
	
	// 글쓰기
	@PostMapping(value = "/boardwrite")
	public ModelAndView boardwrite(Board board, List<MultipartFile> files, HttpSession session) {
		Board writers = new Board();
		writers = bm.boardWrite(board, files, session); // name이 같은 애들로 데려옴
		mav = bm.getContents(writers.getB_num(), writers.getB_id(), session);
		return mav;
	}
	
	// 글삭제
	@PostMapping(value = "/boarddelete")
	public ModelAndView boardDelete(Integer b_num, RedirectAttributes attr, HttpSession session) throws Exception {
		System.out.println("bNum=" + b_num);
		bm.boardDelete(b_num, attr);
		mav = bm.loginBoardHome(session, 1);
		return mav; //
	}

}
