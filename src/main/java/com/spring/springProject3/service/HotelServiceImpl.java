package com.spring.springProject3.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.dao.HotelDao;
import com.spring.springProject3.vo.HotelVo;

@Service
public class HotelServiceImpl implements HotelService {

	@Autowired
	HotelDao hotelDao;

	@Override
	public List<HotelVo> getHotelList() {
		return hotelDao.getHotelList();
	}
	
	// 호텔 등록 처리
	@Override
	public int setHotelInput(HotelVo vo, MultipartFile thumbnailFile) {
		int res = 0;
		
		// 파일 이름 중복처리(UUID)후 서버에 저장처리
		UUID uid = UUID.randomUUID();
		String oFileName = thumbnailFile.getOriginalFilename(); // 업로드한 파일명 가져오기
		String sFileName = vo.getMid() + "_" + uid.toString().substring(0, 8) + "_" + oFileName; // 호텔 등록자 아이디 + uuid + 파일명
		try {
			writeFile(thumbnailFile, sFileName); // 파일을 서버로 저장처리하는 메소드 호출
			res = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		vo.setThumbnail(sFileName);
		
		// 썸네일 외 이미지들 파일 이름 가공
		
		return hotelDao.setHotelInput(vo); // DB 저장 처리
	}
	
	
	// 전송된 파일을 서버로 저장처리
	private void writeFile(MultipartFile thumbnailFile, String sFileName) throws IOException {
		// request 부르기 (Controller에서부터 넘겨도 됨)
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/hotelThumbnail/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(thumbnailFile.getBytes().length != -1) {
			fos.write(thumbnailFile.getBytes());
		}
		fos.flush();
		fos.close();
	}
}
