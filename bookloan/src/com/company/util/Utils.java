package com.company.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.inzenst.crypt.seed.SeedWRapper;


/**
 * Utils
 * 
 * @author 9010661
 * 
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
public class Utils {

	private static ResourceBundle bundle = ResourceBundle
			.getBundle("siv_config");

	public static ResourceBundle getBundle() {
		return bundle;
	}

	/**
	 * Array의 Empty 를 확인
	 * 
	 * @param objs
	 * @return
	 */
	public static boolean isEmptyArray(Object[] objs) {
		return (objs == null || objs.length == 0);
	}

	/**
	 * List 의 Empty를 확인
	 * 
	 * @param list
	 * @return
	 */
	public static boolean isEmptyList(Collection list) {
		return (list == null || list.isEmpty());
	}

	/**
	 * String의 Empty를 확인
	 * 
	 * @param strs
	 * @return
	 */
	public static boolean isEmpty(String... strs) {
		for (int i = 0; i < strs.length; i++) {
			if (strs[i] == null || "".equals(strs[i]))
				return true;
		}
		return false;
	}

	/**
	 * 데이터를 HTML 데이터 형식으로 변환
	 * 
	 * @param plnstr
	 * @return
	 */
	public static String replaceSecOutput(String plnstr) {
		if (isEmpty(plnstr))
			return plnstr;
		else
			return plnstr.replace("&", "&amp;amp;").replace("<", "&amp;lt;")
					.replace(">", "&amp;gt;").replace("#", "&amp;#35;")
					.replace("\\", "&amp;quot;").replace("'", "&amp;#39;");
	}

	/**
	 * Map 의 Empty 가 아닌지 확인
	 * 
	 * @param map
	 * @return
	 */
	public static boolean isNotEmptyMap(Map map) {
		return !isEmptyMap(map);
	}

	/**
	 * Map 의 Empty 를 확인
	 * 
	 * @param map
	 * @return
	 */
	public static boolean isEmptyMap(Map map) {
		return (map == null || map.isEmpty());
	}

	/**
	 * List 데이터가 Empty가 아닌지 확인
	 * 
	 * @param list
	 * @return
	 */
	public static boolean isNotEmptyList(Collection list) {
		return !isEmptyList(list);
	}

	/**
	 * String 데이터 들이 Empty 가 아닌지 확인
	 * 
	 * @param strs
	 * @return
	 */
	public static boolean isNotEmpty(String... strs) {
		return !isEmpty(strs);
	}

	/**
	 * 데이터 타입에 맞는 MimeType 리턴
	 * 
	 * @param fileexe
	 * @return
	 */
	public static String getMimeType(String fileexe) {
		if (mimeTypeMap == null)
			mimeTypeMap = initMimeTypeMap();

		fileexe = fileexe.substring(fileexe.lastIndexOf(".") + 1);
		String mine = (String) mimeTypeMap.get(fileexe);
		return (mine == null ? "application/unknown" : mine);
	}

	/**
	 * 이미지 삽입
	 * 
	 * @param response
	 * @param imgContentsArray
	 */
	public static void sendImage(HttpServletResponse response,
			byte[] imgContentsArray) {
		ServletOutputStream svrOut = null;
		BufferedOutputStream outStream = null;
		try {
			svrOut = response.getOutputStream();
			outStream = new BufferedOutputStream(svrOut);
			outStream.write(imgContentsArray);
			outStream.flush();
		} catch (Exception writeException) {
			writeException.printStackTrace();
		} finally {
			try {
				if (outStream != null)
					outStream.close();
			} catch (Exception closeException) {
				closeException.printStackTrace();
			}
		}
	}

	public static String addLeadingCharacter(String s, char c, int len) {
        while (s != null && s.length() < len) {
            s = c + s;
        }
        return s;
    }
	
	/**
	 * MimeType Map
	 */
	private static Map mimeTypeMap = null;

	/**
	 * mimeTypeMap을 셋팅
	 * 
	 * @return
	 */

	private static Map initMimeTypeMap() {
		HashMap map = new HashMap();
		map.put("grxml", "application/srgs+xml");
		map.put("mpg", "video/mpeg");
		map.put("wmls", "text/vndwapwmlscript");
		map.put("tif", "image/tiff");
		map.put("mpe", "video/mpeg");
		map.put("shar", "application/x-shar");
		map.put("swf", "application/x-shockwave-flash");
		map.put("m3u", "audio/x-mpegurl");
		map.put("spl", "application/x-futuresplash");
		map.put("wmlc", "application/vndwapwmlc");
		map.put("wml", "text/vndwapwml");
		map.put("php", "application/x-httpd-php");
		map.put("ogg", "application/ogg");
		map.put("rpm", "audio/x-pn-realaudio-plugin");
		map.put("mpga", "audio/mpeg");
		map.put("lha", "application/octet-stream");
		map.put("tiff", "image/tiff");
		map.put("kar", "audio/midi");
		map.put("mpeg", "video/mpeg");
		map.put("djvu", "image/vnddjvu");
		map.put("texinfo", "application/x-texinfo");
		map.put("rgb", "image/x-rgb");
		map.put("ppt", "application/vndms-powerpoint");
		map.put("dxr", "application/x-director");
		map.put("mov", "video/quicktime");
		map.put("sgm", "text/sgml");
		map.put("asc", "text/plain");
		map.put("ppm", "image/x-portable-pixmap");
		map.put("etx", "text/x-setext");
		map.put("pgn", "application/x-chess-pgn");
		map.put("tar", "application/x-tar");
		map.put("pgm", "image/x-portable-graymap");
		map.put("bin", "application/octet-stream");
		map.put("css", "text/css");
		map.put("gif", "image/gif");
		map.put("cdf", "application/x-netcdf");
		map.put("xyz", "chemical/x-xyz");
		map.put("tcl", "application/x-tcl");
		map.put("xhtml", "application/xhtml+xml");
		map.put("dms", "application/octet-stream");
		map.put("aif", "audio/x-aiff");
		map.put("jpe", "image/jpeg");
		map.put("midi", "audio/midi");
		map.put("igs", "model/iges");
		map.put("tsv", "text/tab-separated-values");
		map.put("me", "application/x-troff-me");
		map.put("src", "application/x-wais-source");
		map.put("sgml", "text/sgml");
		map.put("iges", "model/iges");
		map.put("man", "application/x-troff-man");
		map.put("xsl", "application/xml");
		map.put("dvi", "application/x-dvi");
		map.put("ez", "application/andrew-inset");
		map.put("ms", "application/x-troff-ms");
		map.put("movie", "video/x-sgi-movie");
		map.put("silo", "model/mesh");
		map.put("jpg", "image/jpeg");
		map.put("sit", "application/x-stuffit");
		map.put("vrml", "model/vrml");
		map.put("pnm", "image/x-portable-anymap");
		map.put("t", "application/x-troff");
		map.put("xslt", "application/xslt+xml");
		map.put("png", "image/png");
		map.put("nc", "application/x-netcdf");
		map.put("doc", "application/msword");
		map.put("mif", "application/vndmif");
		map.put("latex", "application/x-latex");
		map.put("mid", "audio/midi");
		map.put("vxml", "application/voicexml+xml");
		map.put("lzh", "application/octet-stream");
		map.put("xls", "application/vndms-excel");
		map.put("jpeg", "image/jpeg");
		map.put("smil", "application/smil");
		map.put("tr", "application/x-troff");
		map.put("pdf", "application/pdf");
		map.put("js", "application/x-javascript");
		map.put("bcpio", "application/x-bcpio");
		map.put("sv4cpio", "application/x-sv4cpio");
		map.put("sv4crc", "application/x-sv4crc");
		map.put("ief", "image/ief");
		map.put("mathml", "application/mathml+xml");
		map.put("wbmp", "image/vndwapwbmp");
		map.put("cgm", "image/cgm");
		map.put("rdf", "application/rdf+xml");
		map.put("avi", "video/x-msvideo");
		map.put("pdb", "chemical/x-pdb");
		map.put("dtd", "application/xml-dtd");
		map.put("htm", "text/html");
		map.put("mesh", "model/mesh");
		map.put("xul", "application/vndmozillaxul+xml");
		map.put("skm", "application/x-koan");
		map.put("so", "application/octet-stream");
		map.put("aifc", "audio/x-aiff");
		map.put("cpt", "application/mac-compactpro");
		map.put("phps", "application/x-httpd-php-source");
		map.put("class", "application/octet-stream");
		map.put("skp", "application/x-koan");
		map.put("xml", "application/xml");
		map.put("aiff", "audio/x-aiff");
		map.put("rtf", "text/rtf");
		map.put("sh", "application/x-sh");
		map.put("skt", "application/x-koan");
		map.put("texi", "application/x-texinfo");
		map.put("msh", "model/mesh");
		map.put("xbm", "image/x-xbitmap");
		map.put("bmp", "image/bmp");
		map.put("vcd", "application/x-cdlink");
		map.put("eps", "application/postscript");
		map.put("shtml", "text/html");
		map.put("tex", "application/x-tex");
		map.put("wrl", "model/vrml");
		map.put("dll", "application/octet-stream");
		map.put("skd", "application/x-koan");
		map.put("wmlsc", "application/vndwapwmlscriptc");
		map.put("ifb", "text/calendar");
		map.put("exe", "application/octet-stream");
		map.put("rtx", "text/richtext");
		map.put("oda", "application/oda");
		map.put("rm", "audio/x-pn-realaudio");
		map.put("ics", "text/calendar");
		map.put("ico", "image/x-icon");
		map.put("mp3", "audio/mpeg");
		map.put("wav", "audio/x-wav");
		map.put("pbm", "image/x-portable-bitmap");
		map.put("ras", "image/x-cmu-raster");
		map.put("txt", "text/plain");
		map.put("xpm", "image/x-xpixmap");
		map.put("cpio", "application/x-cpio");
		map.put("ra", "audio/x-realaudio");
		map.put("dir", "application/x-director");
		map.put("ice", "x-conference/x-cooltalk");
		map.put("mp2", "audio/mpeg");
		map.put("crl", "application/x-pkcs7-crl");
		map.put("gram", "application/srgs");
		map.put("gtar", "application/x-gtar");
		map.put("qt", "video/quicktime");
		map.put("wbxml", "application/vndwapwbxml");
		map.put("roff", "application/x-troff");
		map.put("snd", "audio/basic");
		map.put("crt", "application/x-x509-ca-cert");
		map.put("zip", "application/zip");
		map.put("mxu", "video/vndmpegurl");
		map.put("svg", "image/svg+xml");
		map.put("php4", "application/x-httpd-php");
		map.put("djv", "image/vnddjvu");
		map.put("php3", "application/x-httpd-php");
		map.put("xwd", "image/x-xwindowdump");
		map.put("au", "audio/basic");
		map.put("dcr", "application/x-director");
		map.put("ai", "application/postscript");
		map.put("ram", "audio/x-pn-realaudio");
		map.put("hqx", "application/mac-binhex40");
		map.put("hdf", "application/x-hdf");
		map.put("ustar", "application/x-ustar");
		map.put("html", "text/html");
		map.put("smi", "application/smil");
		map.put("phtml", "application/x-httpd-php");
		map.put("tgz", "application/x-tar");
		map.put("csh", "application/x-csh");
		map.put("xht", "application/xhtml+xml");
		map.put("ps", "application/postscript");
		return map;
	}

	/**
	 * Object을 String으로 변환
	 * 
	 * @param object
	 * @return
	 */
	public static String defaultString(Object object) {
		if (object == null)
			return StringUtils.defaultString(null);
		else
			return StringUtils.defaultString(object.toString());
	}

	/**
	 * 문자열로 변환
	 * 
	 * @param celValue
	 * @return
	 */
	public static String toString(Object celValue) {
		if (celValue == null)
			return null;
		if (celValue instanceof byte[])
			return new String((byte[]) celValue);
		return String.valueOf(celValue);
	}

	private static String keyfilename;
	private static byte[] keys = null;

	public static String seedEncode(String str) throws Exception {

		if (keys == null) {
			init_seed();
		}
		str = SeedWRapper.encryptAndEncoding(str, keyfilename);
		return str;
	}

	private synchronized static void init_seed() throws Exception {
		keyfilename = Utils.getBundle().getString("KEY_FILE_NAME");
		FileInputStream get = new FileInputStream(new File(keyfilename));

		byte[] bs = new byte[512];
		byte[] result = null;
		keys = new byte[0];
		int i = 0;
		try {
			while ((i = get.read(bs)) > 0) {
				result = new byte[i + keys.length];
				System.arraycopy(keys, 0, result, 0, keys.length);
				System.arraycopy(bs, 0, result, keys.length, i);
				keys = result;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try { get.close(); } catch (IOException e) {}
		}
	}

	public static String seedDecode(String str) throws Exception {

		if (keys == null) {
			init_seed();
		}
		str = SeedWRapper.decodeAndDecrypt(str, keys);
		return str;
	}

	public static void main(String[] args) throws Exception {
		/*
		 * g81MeePxyGektPuPfB0hDg== sF3OlL2OSOShEzY8PHBgHg==
		 */
		
		// System.out.println(seedDecode("g81MeePxyGektPuPfB0hDg=="));
		
//		System.out.println(seedDecode("IoKVw9T/QTgghgtt613SOA=="));
//		System.out.println(seedDecode("j6HcuXeuURgy/DO2VmILMw=="));
//		System.out.println(seedEncode("8610021850017"));
		
//		String str="강남센터";
//		System.out.println(str.indexOf("강남센터"));
//		System.out.println("["+str.substring(str.indexOf("강남센터"),4)+"]");
//		System.out.println("["+str.substring(str.indexOf("강남센터")+4,str.length())+"]");
		
		String str = "AB EF";
		
		String[] strs = str.split(" ");
		
		System.out.println(strs.length);

		String strLastName = strs[strs.length-1];
		System.out.println("LastName:"+strLastName);
		
		String strNewName = "";
		for (int i = 0; i < (strs.length - 1); i++) {
			strNewName += strs[i].charAt(0) + ".";
			strNewName += " ";
		}
		System.out.println(strNewName + strLastName);
		
	}

}
