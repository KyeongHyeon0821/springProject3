package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.FaqVo;

public interface FaqService {

	List<FaqVo> getFaqList(int startIndexNo, int pageSize, String choice);

	int setAdFaqInputOk(FaqVo vo);

}
