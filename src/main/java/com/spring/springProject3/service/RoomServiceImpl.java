package com.spring.springProject3.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.dao.RoomDao;
import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.RoomVo;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	RoomDao roomDao;

	// 객실 등록 처리 (1.썸네일 파일 이름 중복처리 후 저장, 2.썸네일용 이미지파일 만들고 저장, 3.썸네일 외 이미지들 저장, 4.DB저장
	@Override
	public int setRoomInput(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles) {
		// 1.썸네일 파일 이름 중복처리 후 서버에 저장처리
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String oFileName = thumbnailFile.getOriginalFilename(); // 업로드한 파일명 가져오기
		String sFileName = vo.getHotelIdx() + "_" + sdf.format(date) + "_" + oFileName; // 호텔 아이디 + "_" + 날짜 + "_" + oFileName;
		String urlPath = "roomThumbnail";
		try {
			writeFile(thumbnailFile, sFileName, urlPath); // 파일을 서버로 저장처리하는 메소드 호출
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}	
		vo.setThumbnail(sFileName);
		
		// 2. 썸네일용 이미지 파일 만들기 (s_mid_날짜_oFileName)
		setThumbnailCreate(thumbnailFile, urlPath, sFileName);
	
		// 3. 썸네일 외 이미지들 저장처리
		
		List<MultipartFile> fileList = imageFiles.getFiles("imageFiles");
		if(fileList != null && !fileList.isEmpty()) {
			try {
				String sFileNames = "";
				urlPath = "roomImages";
				for(MultipartFile file : fileList) {
					if(!file.isEmpty()) {
						oFileName = file.getOriginalFilename();
						sFileName = vo.getHotelIdx() + "_" + sdf.format(date) + "_" + oFileName; // 호텔 아이디 + "_" + 날짜 + "_" + oFileName;
						writeFile(file, sFileName, urlPath);
						sFileNames += sFileName + "/";
					}
				}
				if(!sFileNames.equals("")) sFileNames = sFileNames.substring(0, sFileNames.length()-1);
				vo.setImages(sFileNames);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// 4. DB 저장처리
		return roomDao.setRoomInput(vo);
	}
	
	
	//전송된 파일을 서버로 저장처리
	private void writeFile(MultipartFile imageFile, String sFileName, String urlPath) throws IOException {
		// request 부르기 (Controller에서부터 넘겨도 됨)
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/") + urlPath + "/";
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(imageFile.getBytes().length != -1) {
			fos.write(imageFile.getBytes());
		}
		fos.flush();
		fos.close();
	}
	
	// 썸네일용 이미지 파일 만들기 (s_mid_날짜_oFileName)
	public void setThumbnailCreate(MultipartFile file, String urlPath, String sFileName) {
		try {
			// 썸네일 파일이 저장될 경로설정
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/") + urlPath + "/";
			File realFileName = new File(realPath + sFileName);
			file.transferTo(realFileName);
			
			// 썸메일 이미지 생성 저장하기
			String thumbnailSaveName = realPath + "s_" + sFileName;
			File thumbnailFile = new File(thumbnailSaveName);
			
			int width = 160;
			int height = 120;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	@Override
	public List<OptionVo> getOptionList() {
		return roomDao.getOptionList();
	}


	@Override
	public int getMaxIdx() {
		return roomDao.getMaxIdx();
	}


	@Override
	public int setRoomOptions(int roomIdx, int optionIdx) {
		return roomDao.setRoomOptions(roomIdx, optionIdx);
	}




	
}
