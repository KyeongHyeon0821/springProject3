package com.spring.springProject3.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.dao.QnaDao;
import com.spring.springProject3.vo.QnaVo;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<QnaVo> getQnaList(int startIndexNo, int pageSize, String mid) {
		return qnaDao.getQnaList(startIndexNo, pageSize, mid);
	}

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "qna/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리 (필터같은 기능을 함! 진짜 파일에 저장되기전에 큰파일에 한번 저장해놓고 여기서 거른다음에 진짜 파일에 저장하러감)
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int setQnaInputOk(QnaVo vo) {
		return qnaDao.setQnaInputOk(vo);
	}



}
