package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.InquiryVo;

public interface AdminService {

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize);

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String choice);
	
	
}
