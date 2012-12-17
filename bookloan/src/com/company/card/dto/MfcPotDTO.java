package com.company.card.dto;

public class MfcPotDTO extends PagingBean {

	private String pot_idno;
	private byte[] pot_poto;
	private String pot_wknm;
	private String pot_updt;
	private String pot_cmnt;
	
	public String getPot_idno() {
		return pot_idno;
	}
	public void setPot_idno(String pot_idno) {
		this.pot_idno = pot_idno;
	}
	public String getPot_wknm() {
		return pot_wknm;
	}
	public void setPot_wknm(String pot_wknm) {
		this.pot_wknm = pot_wknm;
	}
	public String getPot_updt() {
		return pot_updt;
	}
	public void setPot_updt(String pot_updt) {
		this.pot_updt = pot_updt;
	}
	public String getPot_cmnt() {
		return pot_cmnt;
	}
	public void setPot_cmnt(String pot_cmnt) {
		this.pot_cmnt = pot_cmnt;
	}
	public byte[] getPot_poto() {
		return pot_poto;
	}
	public void setPot_poto(byte[] pot_poto) {
		this.pot_poto = pot_poto;
	}

}
