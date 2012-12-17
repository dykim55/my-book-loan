package com.company.card.batch;

import java.util.List;

import com.company.card.dto.MfcSavDTO;


/**
 * @author
 * 
 */
public interface IBatchService {

	public List<MfcSavDTO> searchBatchSaveInfo(MfcSavDTO dto) throws Exception;
	
}
