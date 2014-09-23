package DAO;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import DAO.Category_descriptionDAO;
/*
 * TODO
 * int addDescription (String description, int product, int category)
 * Map<String, List<String>> getDescription (int product, int category)
 * boolean updateDescription (int description_ID, String new_description)
 */
public class Product_descriptionDAO extends DatabaseObject{
	private static final String name = "Product_description";
	private static Product_descriptionDAO instance = null;
	private static Category_descriptionDAO cat_desc = null;
	protected Product_descriptionDAO(){
	
		super();
		cat_desc = Category_descriptionDAO.getInstance();
	}
	
	public static Product_descriptionDAO getInstance() {
		if (instance == null) {
			instance = new Product_descriptionDAO();
			return instance;
		}
		else
			return instance;
	}
	
	
	public String getName() {
	   return name;
	}
	
	public Document getXMLDocumentByID (int ID) {
		String XML_data = null;
		
		Map<String, List<String>> cat_cond = new HashMap<String, List<String>>();
		populate_columns(cat_cond);
		cat_cond.get("ID").add(Integer.toString(ID));
		SAXBuilder builder = new SAXBuilder();
		XML_data = select(cat_cond,true).get("XML_tags").get(0);
		Reader xmlReader = new StringReader(XML_data);
		Document document = null;
		try {
			document = (Document) builder.build(xmlReader);
		} catch (JDOMException e) {} 
		catch (IOException e) {}
		return document;
		
	}
	
	public Document getXMLDocumentByProductID (int Product_ID) {
		String XML_data = null;
		
		Map<String, List<String>> cat_cond = new HashMap<String, List<String>>();
		
		populate_columns(cat_cond);
		cat_cond.get("Product_ID").add(Integer.toString(Product_ID));
		SAXBuilder builder = new SAXBuilder();
		Map<String, List<String>> result = select(cat_cond,true);
		if (result != null) {
			XML_data = select(cat_cond,true).get("XML_description").get(0);
			Reader xmlReader = new StringReader(XML_data);
			Document document = null;
			try {
				document = (Document) builder.build(xmlReader);
			} catch (JDOMException e) {} 
			catch (IOException e) {}
			return document;
		}else
			return null;
		
	}
	
	public List<Element> getXMLChildren(int category_desc_ID) {
		Element rootNode = cat_desc.getXMLDocumentByID(category_desc_ID).getRootElement();
		List<Element> list = rootNode.getChildren();
		return list;
	}
	
	public List<Element> getXMLChildrenByCategoryID(int category_ID) {
		Element rootNode = cat_desc.getXMLDocument(category_ID).getRootElement();
		List<Element> list = rootNode.getChildren();
		return list;
	}
	
	public List<Attribute> getXMLAttributes(Element XMLElement) {
		return  cat_desc.getXMLAttributes(XMLElement);
	}
	
	public int addProductDescription(String XML, int CategoryDesc_ID, int Product_ID) {
		Map<String, List<String>> newProduct = new HashMap<String, List<String>>();
		populate_columns(newProduct);
		
		newProduct.get("ID").add(null);
		newProduct.get("XML_description").add(XML);
		newProduct.get("Category_description_ID").add(Integer.toString(CategoryDesc_ID));
		newProduct.get("Product_ID").add(Integer.toString(Product_ID));
		return insert(newProduct);
	}
}