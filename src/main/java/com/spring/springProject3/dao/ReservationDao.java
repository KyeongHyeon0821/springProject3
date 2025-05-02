package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;

public interface ReservationDao {

	int setReservationInput(@Param("vo") ReservationVo vo);

	void setReservationUpdateToDone();

	void setReservationAutoCancel();

	int setReservationPaymentOk(@Param("reservationNo") String reservationNo);

	ReservationVo getReservation(@Param("reservationNo") String reservationNo);

	List<ReservationVo> getMyReservations(@Param("mid") String mid);

	void setReviewSave(@Param("vo") ReviewVo vo);

}
