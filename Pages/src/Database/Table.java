package Database;

/*
 * 
 * 			This class defines an object that controls one table in the database.  select, insert, update, and remove methods are performed on ONE table only.
 * 		There should be a one to one relation between database tables and table instances.
 * 
 * 			Intances created by Database object.
 * 
 */

import java.sql.*;
import java.util.*;
import java.lang.String;
/*
 * TODO Clean up code
 */
public class Table extends ConSOL implements TableObjects {
	String tableName, index;
	List<String> col = null;

	// TODO Clean up table constructor
	public Table(String tableName) {
		super();
		
		ResultSet rs;
		// int end;
		String q = "show columns from ";
		this.tableName = tableName;
		this.col = new ArrayList<String>();
		
		rs = super.query(q + tableName + ";");
		
		// rs=super.query("insert Status (status) values ('manuallyCoded');");
		
		try {
			while (rs.next()) {
				String value = rs.getString(1);
				col.add(value);
				System.out.println(value);
			}

			index = col.get(0);
		} catch (NullPointerException x) {
			System.out.println("Invalid Table Name.");
		} // TODO: security -> remove this
		catch (SQLException x) {
			System.out.println("Invalid Table Name.");
		}// TODO: security -> remove this

		return;
	}

	// TODO Clean up select
	// TODO Select with custom query aka general search

	public Map<String, List<String>> select(
		Map<String, List<String>> condition, boolean exactMatch) {
		//String select_query="", query_identifier;
		String prepared_query="", prepared_builder;
		ResultSet select_result = null;
		PreparedStatement prep_stmt = null;
		Map<String, List<String>> query_result_map = null;
		int results_found = 0;

		if (exactMatch == true) {
			prepared_builder = super.preparedBuilder(condition, Logic.AND_TYPE,
					Equality.EQUALS_ID);
		} else {
			prepared_builder = super.preparedBuilder(condition, Logic.AND_TYPE,
					Equality.LIKE_ID);
		}

		if (prepared_builder == null)
			return null;
		prepared_query = "SELECT ALL * FROM " + tableName;
		if (prepared_builder.length() > 0) {
			prepared_query += " WHERE " + prepared_builder + ";";
		}
		try {
			prep_stmt = dbt.prepareStatement(prepared_query);
			fillPreparedStatement(condition, prep_stmt);
			System.out.println(prepared_query);
			select_result = prep_stmt.executeQuery();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		if (select_result == null)
			return null;
		try {
			query_result_map = new HashMap<String, List<String>>();
			populate_columns(query_result_map);
			while (select_result.next()) {
				results_found+=1;
				for (int x = 0; x < col.size(); x++) {
					// System.out.println (col.get(x) + " : " +
					// select_result.getString(col.get(x)));
					query_result_map.get(col.get(x)).add(
							select_result.getString(col.get(x)));
				}
			}

		} catch (Exception e) {
			System.out.println("EXCEPTION IN SELECT: " + e);
		}
		if (results_found > 0)
			return query_result_map;
		else
			return null;
	}

	// TODO Clean up insert

	public int insert(Map<String, List<String>> newData) {
		String prep_query_find, prep_query_insert, query_build_helper;

		ResultSet result_query_find = null, result_query_confirm = null;
		PreparedStatement prep_stmt_find = null,
							prep_stmt_insert=null;
		int ID_result = 0;

		/*
		 * Here we will check that the new data we're inserting has all fields
		 * filled. If any field has less or more info. We do not proceed. We
		 * have a malformed map.
		 */

		int high_size = 0;
		int low_size = 0;
		for (int x = 0; x < col.size(); x++) {
			
			if (x == 0) {
				high_size = newData.get(col.get(x)).size();
				low_size = newData.get(col.get(x)).size();
			}
			int current_size = newData.get(col.get(x)).size();
			if (current_size > high_size)
				high_size = current_size;
			if (current_size < low_size)
				low_size = current_size;
		}
		if (high_size != low_size)
			return 0;

		System.out.println("Debug1");

		System.out.println("Debug2");
		query_build_helper = super.preparedBuilder(newData, Logic.AND_TYPE,
				Equality.EQUALS_ID);
		System.out.println("Debug3");
		// if(list2 == null || colString == "()" || col.get(0) == null) return
		// -1;
		System.out.println("Debug4");
		prep_query_find = "SELECT " + index + " FROM " + tableName + " WHERE " + query_build_helper + ";";
		System.out.println(prep_query_find + " find");
		try {
			prep_stmt_find = dbt.prepareStatement(prep_query_find);
			fillPreparedStatement(newData, prep_stmt_find);
			System.out.println(prep_query_find);
			result_query_find = prep_stmt_find.executeQuery();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		try {
			if (!result_query_find.next()) { // element was not present. time to
												// insert it
				System.out.println("Inserting");

				prep_query_insert = "INSERT INTO `" + tableName + "` ("
						+ ConSOL.preparedListBuilder(newData, false) + ") VALUES ("
						+ ConSOL.preparedListBuilder(newData, true) + ");";
				System.out.println(prep_query_insert);
				try {
					prep_stmt_insert = dbt.prepareStatement(prep_query_insert);
					fillPreparedStatement(newData, prep_stmt_insert);
					prep_stmt_insert.executeUpdate();
				} catch (Exception e) {
					System.out.println(e);
				}
				super.query(prep_query_insert); // insert data
				result_query_confirm = prep_stmt_find.executeQuery(); // get data
																		// location

				if (!(result_query_confirm.next()))
					return 0; // there was an error getting inserting the data

				try {
					ID_result = result_query_confirm.getInt(1);
					return ID_result;
				} catch (SQLException e) {
					System.out.println("Error getting index."); // TODO:
																// security->
																// remove this
					return 0;
				}
			} else
				ID_result = -(result_query_find.getInt(1));
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ID_result;
	}

	// TODO Clean up update
	public boolean update(Map<String, List<String>> Identifiers,
			Map<String, List<String>> newData) {
		String prep_query, prep_new_values = null, prep_query_identifiers = null,
				real_query, new_values, query_identifiers;
		PreparedStatement prep_stmt = null;
		prep_new_values = super.preparedBuilder(newData, Assignment.LIST_TYPE,
				Equality.EQUALS_ID);
		new_values = super.queryBuilder(newData, Assignment.LIST_TYPE,
				Equality.EQUALS_ID);
		if (prep_new_values == "")
			return false;

		prep_query_identifiers = super.queryBuilder(Identifiers, Assignment.LIST_TYPE,
				Equality.EQUALS_ID);
		query_identifiers = super.queryBuilder(Identifiers, Assignment.LIST_TYPE,
				Equality.EQUALS_ID);
		if (prep_query_identifiers == "")
			return false;

		prep_query = "UPDATE `" + tableName + "` SET " + prep_new_values + " WHERE "
				+ prep_query_identifiers + ";";
		real_query = "UPDATE `" + tableName + "` SET " + new_values + " WHERE "
				+ query_identifiers + ";";

		
		// update_results = this.select(newData, true); <-- this is wrong
		
		return super.update(prep_query, real_query);
	}

	// TODO Clean up remove
	public boolean remove(Map<String, List<String>> condition) {
		String remove_query, prep_remove_query, identifiers, prep_identifiers;

		prep_identifiers = super.preparedBuilder(condition, Logic.AND_TYPE,
				Equality.EQUALS_ID);
		identifiers = super.queryBuilder(condition, Logic.AND_TYPE,
				Equality.EQUALS_ID);
		if (identifiers == "")
			return false;

		remove_query = "DELETE FROM " + tableName + " WHERE " + identifiers
				+ ";";
		prep_remove_query = "DELETE FROM " + tableName + " WHERE " + prep_identifiers
				+ ";";

		System.out.println(prep_remove_query);

		return super.update(prep_remove_query, remove_query);
	}

	// TODO Write method to populate columns of 2d lists
	public boolean populate_columns(Map<String, List<String>> map) {
		map.clear();
		System.out.println(col);
		for (int col_index = 0; col_index < col.size(); col_index += 1) {
			map.put(col.get(col_index), new ArrayList<String>());
		}
		if (map.size() != col.size() || col.size() <= 0)
			return false;
		else
			return true;
	}
	
	/*
	 * Usage: General purpose query
	 *  - Lookup ReviewDAO for reference
	 *  - If you write sql " Reviews.ID as Review_ID" then the return result of this function
	 *  have "Review_ID" in its name, not ID
	 *  - Bc this function uses getColumnLabel , not getColumnName
	 */
	public Map<String, List<String>> sql_query(String queryString, String preparedString, boolean DATACHANGER) {

		ResultSet result = null;
		PreparedStatement prep_stmt=null;
		Map<String, List<String>> query_result_map = null;
		int results_count = 0;
		
		try {
			if (DATACHANGER == false){
				prep_stmt = dbt.prepareStatement(preparedString);
				result = prep_stmt.executeQuery(queryString);
			}else{
				prep_stmt = dbt.prepareStatement(preparedString);
				prep_stmt.executeUpdate(queryString);
				return null;
			}
					
		} catch (Exception e) {
			System.out.println(e);
		}
		
		if (result == null)
			return null;
		
		try {
			query_result_map = new HashMap<String, List<String>>();

			ResultSetMetaData rsmd = result.getMetaData();
			int columnCount = rsmd.getColumnCount();
			
			for (int i = 0; i < columnCount; i++) {
				query_result_map.put(rsmd.getColumnLabel(i+1),
						new ArrayList<String>());
			}
			
			while (result.next()) {
				for (int i = 0; i < columnCount; i++) {
					query_result_map.get(rsmd.getColumnLabel(i+1)).add(result.getString(i+1));
					results_count+=1;
				}
			}

		} catch (Exception e) {
			System.out.println("EXCEPTION IN SELECT: " + e);
		}
		
		//System.out.println(query_result_map);
		if (results_count > 0)
			return query_result_map;
		else
			return null;
	}
	
}