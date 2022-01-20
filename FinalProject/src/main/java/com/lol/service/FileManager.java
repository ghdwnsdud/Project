package com.lol.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lol.bean.BoardFile;
import com.lol.dao.IBoardDao;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class FileManager {

	@Autowired
	private IBoardDao bDao;
	// 파일 경로(다운로드/삭제에서 사용)
	String fullPath = "E:/down/workSpring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Board_youn/";

	public boolean fileUp(List<MultipartFile> files, int bnum, HttpSession session) {
		System.out.println("fileUp");
		// 1.이클립스의 물리적 저장경로 찾기
		String root = session.getServletContext().getRealPath("/");
		System.out.println("root=" + root);
		String path = root + "upload/";
		// 2.서버 클린시 upload폴더가 삭제됨, 폴더 생성을 꼭 할것...
		File dir = new File(path);
		if (!dir.isDirectory()) { // upload폴더 없다면
			dir.mkdir(); // upload폴더 생성
		}

		// 3.파일을 가져오기-파일태그가 1개 일때
		Map<String, String> fMap = new HashMap<String, String>();
		fMap.put("bNum", String.valueOf(bnum)); //"100"
		//List<MultipartFile> fList = multi.getFiles("files");
		boolean f = false;
		for (int i = 0; i < files.size(); i++) {
			// 파일 메모리에 저장
			MultipartFile mf = files.get(i); // 실제파일
			String oriFileName = mf.getOriginalFilename(); // a.txt
			fMap.put("oriFileName", oriFileName);
			// 4.시스템파일이름 생성 a.txt ==>112323242424.txt
			String sysFileName = System.currentTimeMillis() + "."
					+ oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			fMap.put("sysFileName", sysFileName);
			// 5.메모리->실제 파일 업로드
			try {
				mf.transferTo(new File(path + sysFileName)); // 서버upload에 파일 저장
				f = bDao.fileInsert(fMap);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} // for end
		
		return f;
	}
	
	// 파일 삭제
	public void delete(List<BoardFile> bfList) {
		for(BoardFile bf: bfList) {
			File file = new File(fullPath+"upload/"+bf.getBf_sysName());
			if(file.exists()) {
				System.out.println("파일 삭제 성공");
				file.delete();
			}else {
				log.info("이미 삭제된 파일");
			}
		}
	}	
}
