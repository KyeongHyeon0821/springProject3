package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;

public interface HotelDao {

	List<HotelVo> getHotelList();

	int setHotelInput(@Param("vo") HotelVo vo);

	HotelVo getHotel(@Param("idx") int idx);

}
