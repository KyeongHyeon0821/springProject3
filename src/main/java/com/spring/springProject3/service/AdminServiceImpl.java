package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.AdminDao;
import com.spring.springProject3.vo.InquiryVo;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDao adminDao;

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize) {
		return adminDao.getInquiryList(startIndexNo, pageSize);
	}

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String choice) {
		return adminDao.getInquiryList(startIndexNo, pageSize, choice);
	}
}
