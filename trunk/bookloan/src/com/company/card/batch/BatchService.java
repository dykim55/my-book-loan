package com.company.card.batch;

import java.util.List;

import com.company.card.dto.MfcSavDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class BatchService implements IBatchService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<MfcSavDTO> searchBatchSaveInfo(MfcSavDTO dto) throws Exception {
		dto.searchRowCount(connection, "batch.selectBatchSaveInfo-count");
		return connection.queryForList("batch.selectBatchSaveInfo", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
	
}
