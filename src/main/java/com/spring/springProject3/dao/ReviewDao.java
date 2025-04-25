package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.ReservationListVo;

public interface ReviewDao {

	List<ReservationListVo> getRoomUsedList(@Param("mid") String mid);

}
