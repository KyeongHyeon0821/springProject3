package com.spring.springProject3.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.AdminDao;
import com.spring.springProject3.dao.InquiryDao;
import com.spring.springProject3.dao.QnaDao;
import com.spring.springProject3.vo.PageVo;

@Service
public class Pagination {
	
	@Autowired
	InquiryDao inquiryDao;
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	QnaDao qnaDao;

	public PageVo getTotRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVo vo = new PageVo();
		
		int totRecCnt = 0;
		String search = "";
		String searchStr = "";
		String mid = ""; 
		
		
		if(section.equals("inquiry")) {
			mid = part; 
			totRecCnt = inquiryDao.getInquiryTotRecCnt(mid);
		}
		else if(section.equals("adminInquiry")) {
			String choice = searchString;
			totRecCnt = adminDao.getInquiryTotRecCnt(choice);
		}
		else if(section.equals("qna")) { 
			totRecCnt = qnaDao.getQnaTotRecCnt(); 
		}
		else if(section.equals("qna")) { 
			totRecCnt = qnaDao.getQnaTotRecCntSearch(part, searchString); 
		}
		 
		
		if(section.equals("qna") && !searchString.equals("")) {
			search = part;
			if(totRecCnt != 0) pageSize = totRecCnt;
			if(part.equals("title")) searchStr = "제목";
			else if(part.equals("nickName")) searchStr = "닉네임";
			else searchStr = "글내용";
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		vo.setSearch(search);
		vo.setSearchStr(searchStr);
		vo.setSearchString(searchString);
		vo.setPart(part);
		
		return vo;
	}
	
	
	
}
