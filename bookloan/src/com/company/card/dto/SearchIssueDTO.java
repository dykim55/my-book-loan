package com.company.card.dto;

public class SearchIssueDTO extends PagingBean {

	//TB_CARD 테이블 컬럼명
	private String card_count;
	private String card_status;
	private String card_sno;
	private String card_udt_time;
	private String card_department;
	private String card_department_en;
	private String card_group_en;
	private String card_m_name_en;
	private String card_card_type;
	
	//TB_MEMBER 테이블 컬럼명
	private String m_no;
	private String m_name;
	private String m_passwd;
	private String m_regno;
	private String m_authno;
	private String m_department;
	private String m_position;
	private String m_duty;
	private String m_status;
	private String m_group;
	private String m_agree;
	private String m_phone;
	private String m_e_name;
	private String m_place_work;
	private String m_gender;
	private String m_department_name;
	private String m_department_e_name;
	
	//TB_ISSUE 테이블 컬럼명
	private String issue_count;
	private String issue_status;
	private String issue_date;
	private String issue_remark;
	private String issue_notify_dt;
	private String issue_sno;
	private String issue_udt_no;
	private String issue_udt_time;
	private String issue_department;
	private String issue_department_en;
	private String issue_group_en;
	private String issue_m_name_en;
	private String issue_card_type;
	
	//검색조건
	private String p_m_no;
	private String p_m_name;
	private String p_s_date;
	private String p_e_date;
	private String p_dp_code;
	private String p_dp_name;
	private String p_st_code;
	private String p_card_type;
	private String p_group_en;
	private String p_issue_count;

	public String getP_m_no() {
		return p_m_no;
	}
	public void setP_m_no(String p_m_no) {
		this.p_m_no = p_m_no;
	}
	public String getP_s_date() {
		return p_s_date;
	}
	public void setP_s_date(String p_s_date) {
		this.p_s_date = p_s_date;
	}
	public String getP_e_date() {
		return p_e_date;
	}
	public void setP_e_date(String p_e_date) {
		this.p_e_date = p_e_date;
	}
	public String getP_m_name() {
		return p_m_name;
	}
	public void setP_m_name(String p_m_name) {
		this.p_m_name = p_m_name;
	}
	public String getP_dp_code() {
		return p_dp_code;
	}
	public void setP_dp_code(String p_dp_code) {
		this.p_dp_code = p_dp_code;
	}
	public String getP_dp_name() {
		return p_dp_name;
	}
	public void setP_dp_name(String p_dp_name) {
		this.p_dp_name = p_dp_name;
	}
	public String getP_st_code() {
		return p_st_code;
	}
	public void setP_st_code(String p_st_code) {
		this.p_st_code = p_st_code;
	}
	public String getM_no() {
		return m_no;
	}
	public void setM_no(String m_no) {
		this.m_no = m_no;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_passwd() {
		return m_passwd;
	}
	public void setM_passwd(String m_passwd) {
		this.m_passwd = m_passwd;
	}
	public String getM_regno() {
		return m_regno;
	}
	public void setM_regno(String m_regno) {
		this.m_regno = m_regno;
	}
	public String getM_authno() {
		return m_authno;
	}
	public void setM_authno(String m_authno) {
		this.m_authno = m_authno;
	}
	public String getM_department() {
		return m_department;
	}
	public void setM_department(String m_department) {
		this.m_department = m_department;
	}
	public String getM_position() {
		return m_position;
	}
	public void setM_position(String m_position) {
		this.m_position = m_position;
	}
	public String getM_duty() {
		return m_duty;
	}
	public void setM_duty(String m_duty) {
		this.m_duty = m_duty;
	}
	public String getM_status() {
		return m_status;
	}
	public void setM_status(String m_status) {
		this.m_status = m_status;
	}
	public String getM_group() {
		return m_group;
	}
	public void setM_group(String m_group) {
		this.m_group = m_group;
	}
	public String getM_agree() {
		return m_agree;
	}
	public void setM_agree(String m_agree) {
		this.m_agree = m_agree;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_e_name() {
		return m_e_name;
	}
	public void setM_e_name(String m_e_name) {
		this.m_e_name = m_e_name;
	}
	public String getM_place_work() {
		return m_place_work;
	}
	public void setM_place_work(String m_place_work) {
		this.m_place_work = m_place_work;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}
	public String getM_department_name() {
		return m_department_name;
	}
	public void setM_department_name(String m_department_name) {
		this.m_department_name = m_department_name;
	}
	public String getM_department_e_name() {
		return m_department_e_name;
	}
	public void setM_department_e_name(String m_department_e_name) {
		this.m_department_e_name = m_department_e_name;
	}
	public String getIssue_count() {
		return issue_count;
	}
	public void setIssue_count(String issue_count) {
		this.issue_count = issue_count;
	}
	public String getIssue_status() {
		return issue_status;
	}
	public void setIssue_status(String issue_status) {
		this.issue_status = issue_status;
	}
	public String getIssue_date() {
		return issue_date;
	}
	public void setIssue_date(String issue_date) {
		this.issue_date = issue_date;
	}
	public String getIssue_remark() {
		return issue_remark;
	}
	public void setIssue_remark(String issue_remark) {
		this.issue_remark = issue_remark;
	}
	public String getIssue_notify_dt() {
		return issue_notify_dt;
	}
	public void setIssue_notify_dt(String issue_notify_dt) {
		this.issue_notify_dt = issue_notify_dt;
	}
	public String getIssue_sno() {
		return issue_sno;
	}
	public void setIssue_sno(String issue_sno) {
		this.issue_sno = issue_sno;
	}
	public String getIssue_udt_no() {
		return issue_udt_no;
	}
	public void setIssue_udt_no(String issue_udt_no) {
		this.issue_udt_no = issue_udt_no;
	}
	public String getIssue_udt_time() {
		return issue_udt_time;
	}
	public void setIssue_udt_time(String issue_udt_time) {
		this.issue_udt_time = issue_udt_time;
	}
	public String getCard_count() {
		return card_count;
	}
	public void setCard_count(String card_count) {
		this.card_count = card_count;
	}
	public String getCard_status() {
		return card_status;
	}
	public void setCard_status(String card_status) {
		this.card_status = card_status;
	}
	public String getCard_sno() {
		return card_sno;
	}
	public void setCard_sno(String card_sno) {
		this.card_sno = card_sno;
	}
	public String getCard_udt_time() {
		return card_udt_time;
	}
	public void setCard_udt_time(String card_udt_time) {
		this.card_udt_time = card_udt_time;
	}
	public String getCard_department() {
		return card_department;
	}
	public void setCard_department(String card_department) {
		this.card_department = card_department;
	}
	public String getCard_department_en() {
		return card_department_en;
	}
	public void setCard_department_en(String card_department_en) {
		this.card_department_en = card_department_en;
	}
	public String getCard_group_en() {
		return card_group_en;
	}
	public void setCard_group_en(String card_group_en) {
		this.card_group_en = card_group_en;
	}
	public String getCard_m_name_en() {
		return card_m_name_en;
	}
	public void setCard_m_name_en(String card_m_name_en) {
		this.card_m_name_en = card_m_name_en;
	}
	public String getCard_card_type() {
		return card_card_type;
	}
	public void setCard_card_type(String card_card_type) {
		this.card_card_type = card_card_type;
	}
	public String getIssue_department() {
		return issue_department;
	}
	public void setIssue_department(String issue_department) {
		this.issue_department = issue_department;
	}
	public String getIssue_department_en() {
		return issue_department_en;
	}
	public void setIssue_department_en(String issue_department_en) {
		this.issue_department_en = issue_department_en;
	}
	public String getIssue_group_en() {
		return issue_group_en;
	}
	public void setIssue_group_en(String issue_group_en) {
		this.issue_group_en = issue_group_en;
	}
	public String getIssue_m_name_en() {
		return issue_m_name_en;
	}
	public void setIssue_m_name_en(String issue_m_name_en) {
		this.issue_m_name_en = issue_m_name_en;
	}
	public String getIssue_card_type() {
		return issue_card_type;
	}
	public void setIssue_card_type(String issue_card_type) {
		this.issue_card_type = issue_card_type;
	}
	public String getP_card_type() {
		return p_card_type;
	}
	public void setP_card_type(String p_card_type) {
		this.p_card_type = p_card_type;
	}
	public String getP_group_en() {
		return p_group_en;
	}
	public void setP_group_en(String p_group_en) {
		this.p_group_en = p_group_en;
	}
	public String getP_issue_count() {
		return p_issue_count;
	}
	public void setP_issue_count(String p_issue_count) {
		this.p_issue_count = p_issue_count;
	}
    
}
