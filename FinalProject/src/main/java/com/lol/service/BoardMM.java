package com.lol.service;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lol.bean.Board;
import com.lol.bean.BoardFile;
import com.lol.bean.Reply;
import com.lol.bean.Thumb;
import com.lol.dao.IBoardDao;

@Service
public class BoardMM {

	@Autowired
	private IBoardDao bDao;

	@Autowired
	private FileManager fm;

	ModelAndView mav;

	public ModelAndView loginBoardHome(HttpSession session, int pageNum) {
		mav = new ModelAndView();
		String view = null;
		List<Board> bList = null;
		List<Board> top3List = null;

		// 전체 페이지 가져옴
		int totalPage = bDao.getBoardCount();

		// 추천수 갱신
		bDao.updateBoardThumb();

		// 게시판 홈 데이터 가져오기 ( 1페이지로 )
		bList = bDao.getBoardList(pageNum);

		// top3 list 데이터 가져오기
		top3List = bDao.getTop3List();

		if (bList != null && bList.size() != 0) {
			mav.addObject("bList", bList);
			mav.addObject("top3List", top3List);
			mav.addObject("pageBtn", makeHtmlPage(totalPage, pageNum));

			view = "boardList";
		} else {
			view = "login";
		}
		mav.setViewName(view);
		return mav;
	}
	// 게시판 리스트

	private String makeHtmlPage(int totalPage, int currentPage) {
		StringBuffer sb = new StringBuffer();
		// 현재그룹의 시작 페이지 번호
		int lastPage = (totalPage % 10) > 0 ? (totalPage / 10 + 1) : totalPage / 10;

		if (currentPage == 1) {
			sb.append("<a href='moveboardpage?pageNum=" + (currentPage + 1) + "'>");
			sb.append("<img src='./image/next.png'>");
			sb.append("</a>");

		} else if (currentPage == lastPage) {
			sb.append("<a href='moveboardpage?pageNum=" + (currentPage - 1) + "'>");
			sb.append("<img src='./image/prev.png'>");
			sb.append("</a>");
		} else {
			sb.append("<a href='moveboardpage?pageNum=" + (currentPage - 1) + "'>");
			sb.append("<img src='./image/prev.png'>");
			sb.append("</a>");
			sb.append("<a href='moveboardpage?pageNum=" + (currentPage + 1) + "'>");
			sb.append("<img src='./image/next.png'>");
			sb.append("</a>");

		}
		return sb.toString();
	}

	public int viewUpdate(Integer B_NUM) {

		return bDao.viewCntUp(B_NUM);
	}

	public ModelAndView getContents(Integer bNum, String m_id, HttpSession session) {
		mav = new ModelAndView();

		String view = null;

		// 사용자가 선택한 글의 글번호를 보내주어서 board bean으로 받아온다.
		Board board = bDao.getContents(bNum);

		mav.addObject("board", board);
		// 추천한 적이 있다면 컬러이미지만 표시
		int check_t_id = 1;

		if (m_id == null || "".equals(m_id)) { // 로그인안해서 세션에 m_id가 없다면
			check_t_id = 2;

		} else {// 로그인은 했는데
			Thumb thumb = new Thumb(bNum, m_id);
			String t_id = bDao.checkThumbs(thumb);

			if (t_id == null || "".equals(t_id)) { // 추천한 적이 없다면
				check_t_id = 0;
			}
		}

		mav.addObject("check_t_id", check_t_id);

		// 댓글 리스트도 가져오기
		List<Reply> rList = bDao.getReplyList(bNum);
		mav.addObject("rList", rList);

		// 업로드한 파일리스트 가져오기
		List<BoardFile> bfList = bDao.getBfList(bNum);
		mav.addObject("bfList", bfList); // jstl
		// ObjectMapper로 json변환

		if (board != null) {
			view = "detail";
		} else {
			view = "redirect:/boardlist";
		}

		mav.setViewName(view);

		// 본인글일때 삭제 버튼 생성
		String id = (String) session.getAttribute("m_id");
		String b_id = board.getB_id();

		if (id != null) {
			if (id.equals(b_id)) {
				mav.addObject("delBtn", makeHtmlDelBtn(board.getB_num()));
			}
		}
		return mav;
	}

	private String makeHtmlDelBtn(int b_num) {
		StringBuilder sb = new StringBuilder();
		sb.append("<form id=\"img-submit\" action='boarddelete' method='post'>");
		sb.append("<input type='hidden' name='b_num' value='" + b_num + "'>");
		sb.append("<a href='#' onclick=\"return_img()\" id='delImg'><img src=\"./image/delete.png\"></a>");
		sb.append("</form>");
		return sb.toString();
	}

	public List<Reply> replyInsert(Reply r) {
		List<Reply> rList = null;

		if (bDao.replyInsert(r)) { // 댓글 등록 성공
			rList = bDao.getReplyList(r.getR_bnum()); // 댓글 리스트 검색
		} else {
			rList = null;
		}
		return rList;

	}

	public int addThumbs(Thumb thumb) {
		int result = 0;
		// 이 글에 추천한 적이 있는 사람이냐
		String t_id = bDao.checkThumbs(thumb);

		if (t_id == null || "".equals(t_id)) { // 이미 추천이 있음
			bDao.addThumbs(thumb);
			bDao.updateBoardThumb();
		} else {// 추천한 적이 없다면
				// 세고
		}
		// 전체 추천 수 출력
		result = bDao.countThumbs(thumb);
		return result;
	}

	public Board boardWrite(Board board, List<MultipartFile> files, HttpSession session) {

		board.setB_id(session.getAttribute("m_id").toString());

		// 새 번호의 글에 title과 contents를 넣어준다.
		boolean b = bDao.boardWriteSelectKey(board);
		System.out.println("bnum=" + board.getB_num()); // b_num 확인
		if (b) { // 글쓰기 성공
			if (files.get(0).getSize() != 0) { // 첨부파일이 존재
				if (fm.fileUp(files, board.getB_num(), session))
					System.out.println("upload OK");
			}
		} else { // 글쓰기 실패
		}
		return board;
	}

	@Transactional // 이거 하나로 트랜지션 역할을 한다.
	public void boardDelete(int b_num, RedirectAttributes attr) throws Exception {
		// 첨부파일 여부
		List<BoardFile> bfList = bDao.getBfList(b_num);
		System.out.println("bfList=" + bfList.size());
		boolean f, r, b;
		f = r = b = true;

		// 첨부파일 삭제 f
		if (bfList.size() != 0) {
			f = bDao.bfDelete(b_num); // 삭제실패:false
		}
		System.out.println("f=" + f);

		// 댓글 삭제 r
		List<Reply> rList = bDao.getReplyList(b_num);
		if (rList.size() != 0) {
			r = bDao.replyDelete(b_num);
		}
		System.out.println("r=" + r);

		// board 삭제 b
		b = bDao.boardDelete(b_num);
		System.out.println("b=" + b);

		if (f && r && b) {
			if (f) {
				fm.delete(bfList); // 웹서버에서 파일 삭제
			}
			attr.addFlashAttribute("bNum", b_num);
			System.out.println("삭제트랜잭션 성공");
		} else {
			System.out.println("삭제트랜잭션 실패");
			throw new Exception(); // 예외 발생--->Rollback
		}

	}// boardDelete End

}
