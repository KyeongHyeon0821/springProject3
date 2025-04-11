package com.spring.springProject3.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	// 호텔 등록 처리 (1.썸네일 파일 저장처리, 2.이미지 파일들 이름 가공처리, 3.실제 업로드 된 이미지 파일만 복사처리, 4.DB 저장처리)
	@Override
	public int setHotelInput(HotelVo vo, MultipartFile thumbnailFile) {
		
		// 1.썸네일 파일 이름 중복처리 후 서버에 저장처리
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String oFileName = thumbnailFile.getOriginalFilename(); // 업로드한 파일명 가져오기
		String sFileName = vo.getMid() + "_" + sdf.format(date) + "_" + oFileName; // 호텔 등록자 아이디 + "_" + 날짜 + "_" + oFileName;
		try {
			writeFile(thumbnailFile, sFileName); // 파일을 서버로 저장처리하는 메소드 호출
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		vo.setThumbnail(sFileName);
		
		// 2.썸네일 외 이미지들 파일 이름 가공
		String images = "";
		if(vo.getImages() != null && !vo.getImages().equals("")) {
			String imagesTemp = vo.getImages();
			//      0         1         2         3         4
			//      012345678901234567890123456789012345678901234567890123456789
			// <img src="/springProject3/data/imagesTemp/admin_250411102640_Image20250325143808.jpg" style="height:853px; width:1280px" />
			int position = 37;
			String nextImg = imagesTemp.substring(imagesTemp.indexOf("src=\"/") + position);
			boolean hasImage = true;
			
			while(hasImage) {
				String imgFileName = nextImg.substring(0, nextImg.indexOf("\""));
				images += imgFileName + "/";
				
				if(nextImg.indexOf("src=\"/") == -1) hasImage = false;
				else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		images = images.substring(0, images.length() -1);
		vo.setImages(images);
		
		// 3.파일 복사처리
		String[] imagesArr = vo.getImages().split("/");
		for(String image : imagesArr) {
			fileCopyCheck(image);
		}
		
		// 4.DB 저장 처리
		return hotelDao.setHotelInput(vo);
	}
	
	// 파일 복사처리
	private void fileCopyCheck(String image) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = realPath + "imagesTemp/" + image;
		String copyFilePath = realPath + "hotelImages/" + image;
		
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
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

	@Override
	public HotelVo getHotel(int idx) {
		return hotelDao.getHotel(idx);
	}
}
