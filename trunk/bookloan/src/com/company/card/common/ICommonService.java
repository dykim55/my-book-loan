package com.company.card.common;

import com.company.card.dto.MfcPotDTO;

/**
 * @author
 * 
 */
public interface ICommonService {

	public byte[] getPhotoImage(MfcPotDTO dto) throws Exception;

	public void insertPhotoImage(MfcPotDTO dto) throws Exception;
}
