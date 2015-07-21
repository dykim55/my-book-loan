package com.cyberone.report;

import org.apache.ibatis.session.SqlSession;

public class Common {
	
	private static SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		Common.sqlSession = sqlSession;
	}

	
}
