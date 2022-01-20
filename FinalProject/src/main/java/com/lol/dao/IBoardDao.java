package com.lol.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.lol.bean.Board;
import com.lol.bean.BoardFile;
import com.lol.bean.Reply;
import com.lol.bean.Thumb;


public interface IBoardDao {

	List<Board> getBoardList(Integer pageNum);

	List<Board> getTop3List();
	
	int viewCntUp(Integer B_NUM);
	
	@Select("SELECT COUNT(*) FROM B")
	int getBoardCount();

	Board getContents(Integer bNum);
	

	List<Reply> getReplyList(Integer r_bNum);

	boolean replyInsert(Reply r);

	boolean boardWriteSelectKey(Board board);

	boolean fileInsert(Map<String, String> fMap);

	List<BoardFile> getBfList(Integer bNum);
	
	@Delete("DELETE FROM BF WHERE BF_BNUM=#{bNum}")
	boolean bfDelete(int bNum);
	
	@Delete("DELETE FROM R WHERE R_BNUM=#{bNum}")
	boolean replyDelete(int bNum);
	
	@Delete("DELETE FROM B WHERE B_NUM=#{bNum}")
	boolean boardDelete(int bNum);

	void addThumbs(Thumb thumb);

	int countThumbs(Thumb thumb);

	void updateBoardThumb();

	String checkThumbs(Thumb thumb);


}
