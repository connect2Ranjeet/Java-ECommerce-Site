package DAO;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.Attribute;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;


public class Category_descriptionDAO extends DatabaseObject{
	private static final String name = "Category_description";
	private static Category_descriptionDAO instance = null;
	
	protected Category_descriptionDAO(){
		
		super();
	}
	
	public static Category_descriptionDAO getInstance() {
		if (instance == null) {
			instance = new Category_descriptionDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public Document getXMLDocument (int category_ID) {
		String XML_data = null;
		
		Map<String, List<String>> cat_cond = new HashMap<String, List<String>>();
		populate_columns(cat_cond);
		cat_cond.get("Category_ID").add(Integer.toString(category_ID));
		SAXBuilder builder = new SAXBuilder();
		Map<String,List<String>> result = select(cat_cond, true);
		if (result != null) {
			XML_data = select(cat_cond,true).get("XML_tags").get(0);
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
	public List<Element> getXMLChildren(Document XMLDoc) {
		Element rootNode = XMLDoc.getRootElement();
		List<Element> list = rootNode.getChildren();
		return list;
	}
	public List<Attribute> getXMLAttributes(Element XMLElement) {
		return XMLElement.getAttributes();
	}
	
	public int addCategoryDescription(String value, int Category_ID){
		Map<String, List<String>> newCategoryDesc = new HashMap<String, List<String>>();
		
		populate_columns(newCategoryDesc);
		newCategoryDesc.get("ID").add(null);
		newCategoryDesc.get("XML_tags").add(value);
		newCategoryDesc.get("Category_ID").add(Integer.toString(Category_ID));
		return insert(newCategoryDesc);
		
	}
	
	public int getCategoryDescID (int category_ID) {
		
		Map<String, List<String>> cat_cond = new HashMap<String, List<String>>();
		populate_columns(cat_cond);
		cat_cond.get("Category_ID").add(Integer.toString(category_ID));
		Map<String,List<String>> result = select(cat_cond, true);
		if (result != null) {
			return Integer.parseInt("0"+ result.get("ID").get(0));
		}else
			return 0;
		
	}
	
	
	
}