package Database;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import Action.*;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import DAO.CategoryDAO;
import DAO.Category_descriptionDAO;
import DAO.FeaturedDAO;
import DAO.ImageDAO;
import DAO.Order_numberDAO;
import DAO.ProductDAO;
import DAO.TrendingDAO;
import DAO.UserDAO;
import Database.ConSOL;
import XML.XMLParser;
public class debug {
	
	public static void main(String[] args) {
		//Table ex = new Table("Category"); 
	/*	Map<String, List<String>> users = new HashMap<String, List<String>>();
		Map<String, List<String>> users_search = new HashMap<String, List<String>>();
		Map<String, List<String>> users_old = new HashMap<String, List<String>>();
		Map<String, List<String>> new_user = new HashMap<String, List<String>>();
		Map<String, List<String>> new_user_malformed = new HashMap<String, List<String>>();
		ex.populate_columns(users);
		ex.populate_columns(users_old);
		ex.populate_columns(users_search);
		users.get("ID").add(null);
		users.get("Username").add("new_and_improved!");
		users_search.get("Username").add("%update%");
		
//		users.get("Password").add("pass12345");
	//	users.get("Email").add("email@email.com");
		//users.get("Join_data").add("1234-12-12");
		//statuses.add("test1");
		
		//statuses.add("test3");
		
		//statuses2.add("debug1");
		//statuses2.add("debug2");
		//statuses2.add("debug3");
		
		
	//	System.out.println(conSOL.queryBuilder(users, statuses2));
		
		//statuses.add("javaTest1");
		//statuses.add("javaTest2");
		users_old.get("Username").add(ex.select(users_search, false).get("Username").get(0));
		ex.update(users_old,users);
		ex.remove(users);
		
*/
		/*Order_numberDAO test = Order_numberDAO.getInstance();
		
		test.addOrder("2", 22);
		/*Category_descriptionDAO single = Category_descriptionDAO.getInstance();
		Document document = single.getXMLDocument(3);
		Element rootNode = document.getRootElement();
		List<Element> list = rootNode.getChildren();
		
 
		for (int i = 0; i < list.size(); i++) {
 
		   Element node = list.get(i);
		   System.out.print(node.getName() + " : " + node.getText());
		   if (node.hasAttributes()) {
			   List<Attribute> list3 = node.getAttributes();
			   for (int k = 0; k < list3.size(); k++) {
				   Attribute childAtt = list3.get(k);
				   System.out.print("\t" + childAtt.getName() + " : " + childAtt.getValue());
			   }
		   }
		 
			   System.out.print("\n");
		   
		}

		//System.out.println(singleI.getImage(8));*/
		
		/*Document prodInfo_XML = ProductAction.getXMLDocumentByID(Integer.parseInt("2"));
		Element root = prodInfo_XML.getRootElement();
		List<Element> children = root.getChildren();
		Element desc = root.getChild("description");*/
		/*Map<String, Map<String, List<String>>> test = new HashMap<String, Map<String, List<String>>>();
		test.put("TestTable", new HashMap<String, List<String>>());
		test.get("TestTable").put("TestColumn", new ArrayList<String>());
		test.get("TestTable").get("TestColumn").add("TestValue");
		test.get("TestTable").put("TestColumn2", new ArrayList<String>());
		test.get("TestTable").get("TestColumn2").add("TestValue2");
		test.put("TestTable2", new HashMap<String, List<String>>());
		test.get("TestTable2").put("TestColumn", new ArrayList<String>());
		test.get("TestTable2").get("TestColumn").add("TestValue");
		test.get("TestTable2").put("TestColumn2", new ArrayList<String>());
		test.get("TestTable2").get("TestColumn2").add("TestTable.TestColumn2");
		Map<String, String[]> cond = new HashMap<String, String[]>();
		cond.put("TestTable.TestColumn", new String[2]);
		cond.put("TestTable.TestColumn2", new String[2]);
		cond.get("TestTable.TestColumn")[0] = ConSOL.Equality.EQUALS_ID;
		cond.get("TestTable.TestColumn2")[0] = ConSOL.Equality.EQUALS_ID;
		cond.get("TestTable.TestColumn2")[1] = "||";
		
		cond.put("TestTable2.TestColumn", new String[2]);
		cond.put("TestTable2.TestColumn2", new String[2]);
		cond.get("TestTable2.TestColumn")[0] = ConSOL.Equality.EQUALS_ID;
		cond.get("TestTable2.TestColumn")[1] = ConSOL.Logic.AND_TYPE;
		cond.get("TestTable2.TestColumn2")[0] = ConSOL.Equality.EQUALS_ID;
		cond.get("TestTable2.TestColumn2")[1] = ConSOL.Logic.AND_TYPE;
 		System.out.println(ConSOL.queryBuilder(test, cond));
	
		Table ex = new Table("Images");
		Map<String, List<String>> ustest = new HashMap<String, List<String>>();
		ex.populate_columns(ustest);
	
		ustest.get("Image").add("123");
		ustest.get("Product_ID").add("3");
	
		System.out.println(ex.sql_query("SELECT * FROM Users","SELECT * FROM Users",false));
		System.out.println(ex.remove(ustest));*/
		ProductDAO PD = ProductDAO.getInstance();
		System.out.println(PD.SearchProducts("The Beatles"));
		System.out.println(ConSOL.closeConnection());
		/*Document doc = new Document();
		XMLParser.initializeCategory(doc);
		XMLParser.addCategoryTag(doc, "field1", "New Field", "text", "0");
		XMLParser.addCategoryTag(doc, "field2", "Field List", "list", "0");
		XMLOutputter xmlOutput = new XMLOutputter();
		System.out.println(XMLParser.getCategoryTagMap(doc));
		 
		// display nice nice
		xmlOutput.setFormat(Format.getPrettyFormat());
		
		Document prod = new Document();
		XMLParser.initializeProduct(prod);
		XMLParser.addProductDescription(doc, prod, "description", "12345<p><p> Description");
		XMLParser.addProductDescription(doc, prod, "tags", "tag 1");
		XMLParser.addProductDescription(doc, prod, "tags", "tag 2");
		XMLParser.addProductDescription(doc, prod, "field1", "Field Text 54321");
		XMLParser.addProductDescription(doc, prod, "field2", "List Item1");
		XMLParser.addProductDescription(doc, prod, "field2", "<br>List Item2</br>");
		
		try {
			xmlOutput.output(doc, System.out);
			System.out.println("------------------------------------------------------");
			xmlOutput.output(prod, System.out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(prod.getRootElement().getChild("description").getText());
		*/
		
	}
}