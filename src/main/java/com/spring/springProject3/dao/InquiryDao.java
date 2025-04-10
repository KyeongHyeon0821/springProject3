package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;

public interface InquiryDao {

	int getInquiryTotRecCnt();

	int getInquiryTotRecCntSearch(@Param("part") String part, @Param("searchString") String searchString);

}
