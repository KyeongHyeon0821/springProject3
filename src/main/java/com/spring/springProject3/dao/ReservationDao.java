package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.ReservationVo;

public interface ReservationDao {

	int setReservationInput(@Param("vo") ReservationVo vo);

	void setReservationUpdateToDone();

	void setReservationAutoCancel();

}
