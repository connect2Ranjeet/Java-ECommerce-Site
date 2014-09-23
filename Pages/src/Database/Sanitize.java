package Database;

public class Sanitize {
	
	public String sanitizeSQL(Object x){
		String temp = x.toString();
		
		temp.replace("\\", "");
		temp.replace("'", "");
		temp.replace(";", "");
		temp.replace("\"", "\\\"");
		temp.replace("(", "[");
		temp.replace(")","]");
		
		return null;
	}
	
	
}
