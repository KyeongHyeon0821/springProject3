package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.vo.InquiryVo;

public interface InquiryService {

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize);

	int setInquiryInputOk(MultipartFile mFile, InquiryVo vo);

	InquiryVo getInquiryDetail(int idx);

	void imgDelete(String content);

	int setInquiryDelete(int idx);



}
