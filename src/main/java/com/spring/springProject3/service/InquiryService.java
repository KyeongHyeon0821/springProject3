package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.InquiryVo;

public interface InquiryService {

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize);

}
