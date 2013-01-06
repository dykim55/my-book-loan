import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class HelloServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException{

		try {
			Connection conn = null;
			ResultSet rs = null;
			Statement stmt = null;

			DataSource ds;
			Context initContext = new InitialContext();
			ds = (DataSource) initContext.lookup("java:comp/env/jdbc/CUBRIDDS");//
			conn = ds.getConnection();

			String strJson = "[";
			strJson += "{\"title\": \"Item 1\"},";
			strJson += "{\"title\": \"Folder 2\", \"isFolder\": true, \"key\": \"folder2\",";
			strJson += "\"children\": [";
			strJson += "{\"title\": \"Sub-item 2.1\"},";
			strJson += "{\"title\": \"Sub-item 2.2\"}";
			strJson += "]";
			strJson += "},";
			strJson += "{\"title\": \"Lazy Folder 4\", \"isFolder\": true, \"isLazy\": true, \"key\": \"folder4\"},";
			strJson += "{\"title\": \"Item 5\"}";
			strJson += "]";
			
			PrintWriter out=res.getWriter();
			out.println(strJson);
			out.close();
		} catch(Exception e) {
			getServletContext().log("Error in HelloServlet : ", e);
		}
	}

}

