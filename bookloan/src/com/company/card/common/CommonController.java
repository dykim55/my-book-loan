package com.company.card.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.company.card.dto.MfcPotDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.framework.utils.DateUtil;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class CommonController extends SIVController {

	private ICommonService commonService;
	
	private String defaultImagePath;
	
	private static byte[] defaultImage;
	
	public ModelAndView getImage(HttpServletRequest req, HttpServletResponse res) throws Exception {

		MfcPotDTO dto = (MfcPotDTO) DataUtils.dtoBuilder(req, MfcPotDTO.class);
		
		String strIdno = dto.getPot_idno();
		
		byte[]	image	= null;
		if (strIdno != null && strIdno.length() > 0) {			// DB사진이미지 조회
			image	= commonService.getPhotoImage(dto);
		}
		
		if (image == null) { //서버폴더내에서 조회
			image	= getPhotoImage(req.getSession().getServletContext().getRealPath("WEB-INF") + "/photo/" + strIdno + ".jpg");
		}
		
		if (image == null) { //디폴트이미지 조회
			image	= getDefaultImage(req.getSession().getServletContext().getRealPath("/") + defaultImagePath);
		}
		
		res.getOutputStream().write(image);
		res.getOutputStream().flush();
		
		return null;
	}

	public static byte[] getDefaultImage(String imagePath) {
		if (defaultImage == null) {
			File file = new File(imagePath);
			if (file.exists()) {
				int length = (int)file.length();
				byte[] image = new byte[length];
				FileInputStream	fIn	= null;
				try {
					fIn	= new FileInputStream(file);
					for (int readBytes = 0, totalBytes = 0; totalBytes < length && readBytes > -1; totalBytes += readBytes) {
						readBytes	= fIn.read(image, totalBytes, length - totalBytes);
					}
					defaultImage = image;
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {fIn.close();} catch (Exception e) {}
				}
			}
		}
		return defaultImage;
	}	

	public static byte[] getPhotoImage(String imagePath) {
		File file = new File(imagePath);
		if (file.exists()) {
			int length = (int)file.length();
			byte[] image = new byte[length];
			FileInputStream	fIn	= null;
			try {
				fIn	= new FileInputStream(file);
				for (int readBytes = 0, totalBytes = 0; totalBytes < length && readBytes > -1; totalBytes += readBytes) {
					readBytes	= fIn.read(image, totalBytes, length - totalBytes);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {fIn.close();} catch (Exception e) {}
			}
			return image;
		}
		return null;
	}	

	public ModelAndView imageUpload(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String folder = makeFolder(req.getSession().getServletContext().getRealPath("WEB-INF"), "photo");
		
		String strIdno = req.getParameter("idno");

		logger.info(":::::::::: Photo Image Upload!!! [" + strIdno + "]");
		
		MultipartHttpServletRequest	fileReq	= (MultipartHttpServletRequest)req;
		
		MultipartFile file = fileReq.getFile("photofile");
		byte[] _file = file.getBytes();
		
		String filename	= folder + strIdno + ".jpg";
		
		FileOutputStream fOut = null;
		try {
			fOut = new FileOutputStream(filename);
			fOut.write(_file);
			fOut.flush();
		} catch (Exception e) {
		} finally {
			try { fOut.close(); } catch (Exception e) {}
		}
		
		MfcPotDTO dto = (MfcPotDTO) DataUtils.dtoBuilder(req, MfcPotDTO.class);
		dto.setPot_poto(_file);
		dto.setPot_updt(DateUtil.getYYYYMMDDHH24MISS());
		
		commonService.insertPhotoImage(dto);
		
		return new ModelAndView(this.success);
	}


//첨부파일 폴더 생성
	public String makeFolder(String path, String folder) {
		String	fullPath	= path + "/" + folder + "/";
		File	file	= new File(fullPath);
		if (!file.exists()) file.mkdirs();
		return fullPath;
	}
	
	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}
	
	public void setDefaultImagePath(String defaultImagePath) {
		this.defaultImagePath = defaultImagePath;
	}
	
}
