package com.spring.springProject3.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.springProject3.service.ReservationService;

@Component
public class Scheduler {

	@Autowired
	ReservationService reservationService;
	
	// 매일 밤 12시 예악 상태 없데이트
  @Scheduled(cron = "0 0 0 * * *")
  public void processReservationStatusNightly() {
    reservationService.setReservationAutoCancel();   // 결제대기 -> 예약취소 (당일 미결제시)
    reservationService.setReservationUpdateToDone(); // 결제완료 -> 이용완료 (결제 후 숙박 완료시)
  }
	
}
