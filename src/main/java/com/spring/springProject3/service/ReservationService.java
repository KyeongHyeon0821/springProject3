package com.spring.springProject3.service;

import com.spring.springProject3.vo.ReservationVo;

public interface ReservationService {

	int setReservationInput(ReservationVo vo);

	void setReservationUpdateToDone();

	void setReservationAutoCancel();

}
