package kh.cocoa.statics;

public class Configurator {
	public static int test =0;
	public static int recordCountPerPage = 10;
	public static int recordCountPerPageM = 5;
	public static int naviCountPerPage = 10;
	public static String boardFileRootC = "C:\\boardRepository\\";
	public static String emailFileRootC = "C:\\emailFileRepository\\";
	public static String profileFileRoot ="C:\\profileRepository\\";
	
	//Messenger==================
	public static String messengerFileRoute = "c:\\messengerRepository\\";

	//근태
	public static String XssReplace(String param) {

		param = param.replaceAll("&", "&amp;");
		param = param.replaceAll("\"", "&quot;");
		param = param.replaceAll("'", "&apos;");
		param = param.replaceAll("<", "&lt;");
		param = param.replaceAll(">", "&gt;");
		param = param.replaceAll("\r", "<br>");
		param = param.replaceAll("\n", "<p>");
		return param;
	}

}
