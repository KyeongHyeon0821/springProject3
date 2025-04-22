package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.FaqDao;
import com.spring.springProject3.vo.FaqVo;

@Service
public class FaqServiceImpl implements FaqService {

	@Autowired
	FaqDao faqDao;

	@Override
	public List<FaqVo> getFaqList(int startIndexNo, int pageSize, String choice) {
		return faqDao.getFaqList(startIndexNo, pageSize, choice);
	}

	@Override
	public int setAdFaqInputOk(FaqVo vo) {
		return faqDao.setAdFaqInputOk(vo);
	}

}
