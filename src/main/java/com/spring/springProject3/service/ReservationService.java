package com.spring.springProject3.service;

import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;

public interface ReservationService {

	int setReservationInput(ReservationVo vo);

	void setReservationUpdateToDone();

	void setReservationAutoCancel();

	void setReviewCheckOk(ReviewVo vo);

}
