package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;

public interface HotelDao {

	List<HotelVo> getHotelList();

	int setHotelInput(@Param("vo") HotelVo vo);

	HotelVo getHotel(@Param("idx") int idx);

	int setHotelStatusUpdate(@Param("idx") int idx, @Param("status") String status);

	int setHotelUpdate(@Param("vo") HotelVo vo);

	int getHotelLike(@Param("mid") String mid, @Param("idx") int idx);

	int setHotelLikeOk(@Param("mid") String mid, @Param("hotelIdx") int hotelIdx);

	int setHotelLikeNo(@Param("mid") String mid, @Param("hotelIdx") int hotelIdx);

	List<Integer> getLikedHotelListIdx(@Param("mid") String mid);


}
