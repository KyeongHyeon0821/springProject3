package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.QnaVo;

public interface QnaService {

	List<QnaVo> getQnaList(int startIndexNo, int pageSize, String mid);

	void imgCheck(String content);

	int setQnaInputOk(QnaVo vo);

}
