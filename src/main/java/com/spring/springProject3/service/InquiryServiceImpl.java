package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.InquiryDao;
import com.spring.springProject3.vo.InquiryVo;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	@Autowired
	InquiryDao inquiryDao;

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize) {
		return inquiryDao.getInquiryList(startIndexNo, pageSize);
	}

}
