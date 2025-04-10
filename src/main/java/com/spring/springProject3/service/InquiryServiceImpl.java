package com.spring.springProject3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.InquiryDao;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	@Autowired
	InquiryDao inquiryDao;

}
