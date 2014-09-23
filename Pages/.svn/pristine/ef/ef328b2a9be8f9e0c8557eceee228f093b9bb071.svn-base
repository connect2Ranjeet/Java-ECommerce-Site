package Database;
/*
 * 
 * 			This file manages the static database connection.  It also passes queries to the database and returns their results.  Additional
 * 		function allow for lists to be parsed in a sql query friendly manner.  This contents in this file are dependent on the database
 * 		implementation (i.e. user, password, encryption key, etc.)
 * 
 * 			extended by: table
 */

import java.io.*;
import java.util.*;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;
import java.util.List;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;


public abstract class ConSOL extends AESCipher{
	public final class Logic {
		public final static String AND_TYPE = "&&";
		public final static String OR_TYPE = "||";
	}
	public final class Assignment {
		public final static String LIST_TYPE = ",";
	}
	public final class Equality {
		public final static String LIKE_ID = "LIKE";
		public final static String EQUALS_ID = "=";
	}
	public static Connection dbt = null;
	private String  hostURL="jdbc:mysql://sol.csproject.org",
			databaseStore ="ourstore",
			hostPORT="3306",
			loginName = "solTEAM",
			loginPassword = "pfmSANTORUM",
			databaseArguments = "zeroDateTimeBehavior=convertToNull";
	public String driver = "com.mysql.jdbc.Driver";
	
	//maintain connection as variable
	public Connection getConnection() {
		return dbt;
	}
	
	
	/*
	 * TODO Separate Decrypter from Connection Method
	 */
	public ConSOL(){
		if(dbt!=null) return;
		
		try{
			Class.forName(driver);
			AESCipher cred = new AESCipher();
			byte[] cred_raw=null;
			byte[] open_iv = null;
			String cred_dec=null; // this STAYS!
			//Scanner read = new Scanner(io_credentials);
			
			//maintain connection as variable
			
			// TODO REAPPLY ENCRYPTION BEFORE PROJECT FINISH. Fix file location error.

			/*	AESCipher jazz = new AESCipher();
				String pass = UUID.nameUUIDFromBytes("North Korea is Best Korea".getBytes()).toString();   
				char [] password = pass.toCharArray();
				
				FileInputStream fis=null, fis2=null;
				File reading = new File ("candy_corn.sol"); // Gets IV
				File reading2 = new File ("salted_taffy.sol"); //Gets Cipher
				open_iv = new byte[(int) reading.length()];
				cred_raw = new byte[(int) reading2.length()];
				try {
						fis = new FileInputStream(reading);
						fis2 = new FileInputStream(reading2);
						fis.read(open_iv);
						fis2.read(cred_raw);
						fis.close();
						fis2.close();
				} catch (FileNotFoundException e1) {
					
					e1.printStackTrace();
				} catch (IOException e) {
			
					e.printStackTrace();
				}
				
				try {

					cred_dec = jazz.decrypt(password, open_iv, cred_raw);
				
				} catch (Exception e){
					
				} 
			
			if(open_iv == null || cred_raw == null){
				System.out.println("Couldn't get values from file contents.");  //got file but not values
				return;
			}
			
			try{
				cred_dec = cred.decrypt(password, open_iv, cred_raw);
			}
			catch(InvalidKeySpecException z) {connectError();}
			catch(NoSuchPaddingException p) {connectError();}
			catch(NoSuchAlgorithmException b) {connectError();}
			catch (InvalidKeyException e) {connectError();}
			catch (UnsupportedEncodingException e) {connectError();}
			catch (IllegalBlockSizeException e) {connectError();}
			catch (BadPaddingException e) {connectError();}
			catch (InvalidAlgorithmParameterException e) {connectError();}
			
			// TODO REVERT BACK TO ENCRYPTED CODE FOR FINAL PROJECT
			//loginName = cred_dec.substring(0, cred_dec.indexOf(':'));
			//loginPassword = cred_dec.substring(cred_dec.indexOf(':')+1, cred_dec.length()); */
			loginName="solTEAM";
			loginPassword="pfmSANTORUM";
			dbt = DriverManager.getConnection( hostURL + ":" + hostPORT + "/" + databaseStore + "?" + databaseArguments, loginName, loginPassword);
			/* TODO UNCOMMENT BEFORE PROJECT FINISH
			loginName = loginPassword = pass = cred_dec = null;
			open_iv = cred_raw = null;
			password = null;*/
		}
		catch(SQLException e){
			connectError(e.getMessage());
		} catch (ClassNotFoundException e) {
			connectError(e.getMessage());
		}
	}

	private void connectError(String details){
		System.out.println("Couldn't get connection.");
		System.out.println(details);
		return;
	}
	
	public static boolean closeConnection() {
		try {
			if (dbt != null)
				dbt.close();
			return dbt.isClosed();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return false;
	}
	
	public ResultSet query(String query){
		ResultSet query_result=null;

		try{
			Statement query_statement = dbt.createStatement();
			//execute the query.  True for select statements.
			if(query_statement.execute(query)) query_result = query_statement.getResultSet();
			else{
				query_result=null;
				//Enters this section if there was an insert or update.
				//We can get the rows affected by:
				//
				//int number = st.getUpdateCount() ;
		        //System.out.println( number + " rows affected" ) ;
			}
		}
		catch(SQLException x){
		}
		
		return query_result;
	}

	public boolean update(String prepared_query, String real_query){
		try{
			PreparedStatement query_statement = dbt.prepareStatement(prepared_query);
			if(query_statement.executeUpdate(real_query)>0){
				return true;
			}
			return false;
		}
		catch(SQLException x){
			System.out.println(x);
		}
		return false;
	}
	
	public boolean update(PreparedStatement query){
		try{
			
			if(query.executeUpdate()>0){
				return true;
			}
			return false;
		}
		catch(SQLException x){
			System.out.println(x);
		}
		return false;
	}
	
	public static String queryBuilder(Map<String, List<String>> Values, String VALUE_PROPERTY, String IDENTIFIER_PROPERTY){
		String column_name[] = null;
		
		String result = "";
		String ID_PROP = null;
		if (IDENTIFIER_PROPERTY == Equality.LIKE_ID)
			ID_PROP = " LIKE ";
		else if (IDENTIFIER_PROPERTY == Equality.EQUALS_ID)
			ID_PROP = "=";
		
	
		if(Values==null) return "";
		else if (Values.size() < 1) return "";
		else {
			column_name = new String[Values.keySet().size()];
			Values.keySet().toArray(column_name);
		}
		for (int x = 0; x < column_name.length; x++){
			if (Values.get(column_name[x]).size() > 0 ) //If fields are missing
			{
				String current_value = Values.get(column_name[x]).get(0);
				if (current_value != null) { // If the fields are there, but they're null
					if(result.length() < 1){ // first entry
						result += "`" + column_name[x] + "`" + ID_PROP + "'" + current_value + "'";
				
					}
					else {
						if (VALUE_PROPERTY == Logic.AND_TYPE)
							result += " && ";
						else if (VALUE_PROPERTY == Assignment.LIST_TYPE)
							result += ", ";
						else if (VALUE_PROPERTY == Logic.OR_TYPE)
							result += " || ";
					
						result += "`" + column_name[x] + "`" + ID_PROP + "'" + current_value + "'";
					}
				}
			}
		}
		
		if(result=="") return "";
		System.out.println("ShowEquality " + result);
		return result;
	}
	
	public static String preparedBuilder(Map<String, List<String>> Values, String VALUE_PROPERTY, String IDENTIFIER_PROPERTY){
		String column_name[] = null;
		
		String result = "";
		String ID_PROP = null;
		if (IDENTIFIER_PROPERTY == Equality.LIKE_ID)
			ID_PROP = " LIKE ";
		else if (IDENTIFIER_PROPERTY == Equality.EQUALS_ID)
			ID_PROP = "=";
		else
			ID_PROP = IDENTIFIER_PROPERTY;
		
	
		if(Values==null) return "";
		else if (Values.size() < 1) return "";
		else {
			column_name = new String[Values.keySet().size()];
			Values.keySet().toArray(column_name);
		}
		for (int x = 0; x < column_name.length; x++){
			if (Values.get(column_name[x]).size() > 0 ) //If fields are missing
			{
				String current_value = Values.get(column_name[x]).get(0);
				if (current_value != null) { // If the fields are there, but they're null
					if(result.length() < 1){ // first entry
						if (ID_PROP.length() > 0)
							result += "`" + column_name[x] + "`" + ID_PROP + "?";
						else
							result += "`" + column_name[x] + "`";
				
					}
					else {
						if (VALUE_PROPERTY == Logic.AND_TYPE)
							result += " && ";
						else if (VALUE_PROPERTY == Assignment.LIST_TYPE)
							result += ", ";
						else if (VALUE_PROPERTY == Logic.OR_TYPE)
							result += " || ";
						else
							result += " " + VALUE_PROPERTY + " ";
					
						if (ID_PROP.length() > 0)
							result += "`" + column_name[x] + "`" + ID_PROP + "?";
						else
							result += "`" + column_name[x] + "`";
					}
				}
			}
		}
		
		if(result=="") return "";
		System.out.println("ShowEquality " + result);
		return result;
	}
	
	public static boolean fillPreparedStatement(Map<String,List<String>> columnsAndValues, PreparedStatement prep_stmt){
		String column_name[] = null;
		int hits = 0;
	
		if(columnsAndValues==null) return false;
		else if (columnsAndValues.size() < 1) return false;
		else{
			try{
				column_name = new String[columnsAndValues.keySet().size()];
				columnsAndValues.keySet().toArray(column_name);
				
				for (int x = 0; x < column_name.length; x++){
					if (columnsAndValues.get(column_name[x]).size() > 0 ) //If fields are missing
					{
						String current_value = columnsAndValues.get(column_name[x]).get(0);
						if (current_value != null) { // If the fields are there, but they're null
							hits+=1;
							prep_stmt.setString(hits, current_value); //PreparedStatements have a starting index of 0
							
						}
					}
				}
			}catch(Exception e){
				System.out.println(e);
			}
		}
		if(hits < 1) return false;
		else
			return true;
	}
	

	
	public static String listBuilder(Map<String, List<String>> Values, boolean LIST_VALUES){
		String column_name[] = new String[Values.keySet().size()];
		Values.keySet().toArray(column_name);
		String result = "";
		if (LIST_VALUES == true) {
			for (int x=0;x<column_name.length;x++) {
				if (Values.get(column_name[x]).size() > 0) {
					String current_value = Values.get(column_name[x]).get(0);
					if (result.length() > 0 && current_value != null)
						result += ", ";
					if (current_value != null) 
						result += "'" + current_value + "'";
				}
			}
		} else {
			for (int x=0;x<column_name.length;x++) {
				if (Values.get(column_name[x]).size() > 0) {
					String current_value = Values.get(column_name[x]).get(0);
					if (result.length() > 0 && current_value != null)
						result += ", ";
					if (current_value != null) 
						result += "`" + column_name[x] + "`";
				}
	
			}
		}
		return result;
	}
	
	public static String preparedListBuilder(Map<String, List<String>> Values, boolean LIST_VALUES){
		String column_name[] = new String[Values.keySet().size()];
		Values.keySet().toArray(column_name);
		String result = "";
		if (LIST_VALUES == true) {
			for (int x=0;x<column_name.length;x++) {
				if (Values.get(column_name[x]).size() > 0) {
					String current_value = Values.get(column_name[x]).get(0);
					if (result.length() > 0 && current_value != null)
						result += ", ";
					if (current_value != null) 
						result += "?";
				}
			}
		} else {
			for (int x=0;x<column_name.length;x++) {
				if (Values.get(column_name[x]).size() > 0) {
					String current_value = Values.get(column_name[x]).get(0);
					if (result.length() > 0 && current_value != null)
						result += ", ";
					if (current_value != null) 
						result += "`" + column_name[x] + "`";
				}
	
			}
		}
		return result;
	}
}