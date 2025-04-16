package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.QnaVo;

public interface QnaDao {

	List<QnaVo> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	int setQnaInputOk(@Param("vo") QnaVo vo);

}
