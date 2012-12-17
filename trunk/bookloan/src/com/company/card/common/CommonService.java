package com.company.card.common;

import com.company.card.dto.MfcPotDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class CommonService implements ICommonService {
	
	private SqlMapClient connection;

	/**
	 * 사진이미지를 조회.
	 * 
	 * @param MfcPotDTO
	 * @return byte[]
	 * @throws Exception
	 */
	public byte[] getPhotoImage(MfcPotDTO dto) throws Exception {
		MfcPotDTO result = (MfcPotDTO)connection.queryForObject("common.searchPhotoImage", dto);
		if (result != null) {
			return (byte[])result.getPot_poto();
		}
		
		return null;
	}

	public void insertPhotoImage(MfcPotDTO dto) throws Exception {
		int applyCnt = connection.update("common.updatePhotoImage", dto);
		if (applyCnt < 1) {
			connection.insert("common.insertPhotoImage", dto);
		}
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
