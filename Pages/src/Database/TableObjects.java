package Database;
/*
 * 
 * 			This interface defines a type of object that, by requirement, have the methods select, insert, update, and remove defined.  When table implements this
 * 		it allows a type to be defined that can perform these methods independent of which dababase table the table object is referencing (independent of column
 * 		number and type as well).
 * 
 * 			implemented by: table
 * 
 */

import java.sql.ResultSet;
import java.util.*;


public abstract interface TableObjects {
	
	public abstract Map<String,List<String>> select(Map<String, List<String>> conditions, boolean exactMatch);
	
	public abstract int insert(Map<String,List<String>> newData);
	
	public abstract boolean update(Map<String, List<String>> Identifiers, Map<String, List<String>> newData);
	
	public abstract boolean remove(Map<String, List<String>> condition);
	
	public Map<String, List<String>> sql_query(String queryString, String preparedString, boolean DATACHANGER);
	
	public abstract boolean populate_columns (Map<String, List<String>> map);
}