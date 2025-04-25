package com.spring.springProject3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.ReservationDao;
import com.spring.springProject3.vo.ReservationVo;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	ReservationDao reservationDao;

	@Override
	public int setReservationInput(ReservationVo vo) {
		return reservationDao.setReservationInput(vo);
	}

	@Override
	public void setReservationStatusUpdate() {
		reservationDao.setReservationStatusUpdate();
	}
}
