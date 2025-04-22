package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.ComplaintVo;
import com.spring.springProject3.vo.InquiryVo;

public interface AdminService {


	int setBoardComplaintInput(ComplaintVo vo);

	void setBoardTableComplaintOk(int partIdx);
	
	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize);

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String choice);

	InquiryVo getInquiryDetail(int idx);

	int setInquiryReplyOk(int idx, String reContent);

	void setInquiryReplyStatusOk(int idx);

	int setAdInquiryDetailUpdate(int reIdx, String reContent);

	int setAdInquiryDetailHold(int idx);
}
