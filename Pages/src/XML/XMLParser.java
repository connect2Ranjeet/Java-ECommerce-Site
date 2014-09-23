package XML;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;

public class XMLParser {
	/* ----------- XML TYPES ------------- */
	public enum XMLType {
	list,
	list_numbered,
	text,
	html,
	image,
	description,
	tag;
	}
	public enum DisplayType {
		all,
		essential,
		nonessential,
		list,
		list_numbered,
		text,
		html,
		image,
		description,
		tag;
	}
	public static String HeaderTag[] ={"<h5>","</h5><p>"};
	public static String SegmentTag[] = {"",""};
	
	private static Map<XMLType, List<String>> initializeMap(){
		Map<XMLType, List<String>> map = new HashMap<XMLType, List<String>>();
		XMLType types[] = XMLType.values();
		for (int x = 0; x < types.length; x++)
			map.put(types[x], new ArrayList<String>());
		return map;
	}
	
	public static Map<XMLType, List<String>> ParseXMLDocumentToHTML(Document prodInfo_XML, Document catInfo_XML, DisplayType display){
		Element prod_root = null;
		Element cat_root = null;
		List<Element> cat_children = null;
		Map<XMLType, List<String>> XMLMap = initializeMap();
		if (prodInfo_XML != null) {
			prod_root = prodInfo_XML.getRootElement();
		}
		//System.out.println(prodInfo_XML);
		// Get Category XML Description (contains properties & types)
		
		if (catInfo_XML != null) {
			cat_root = catInfo_XML.getRootElement();
			cat_children = cat_root.getChildren();
		}
		try {
			if (cat_children != null) {
				for (int cat_i=0; cat_i < cat_children.size(); cat_i++){
					Attribute cat_name = null, cat_type = null;
					XMLType xmltype = null;
					
					String cat_xml_name = cat_children.get(cat_i).getName().toLowerCase();
					Element prod_child = prod_root.getChild(cat_xml_name);
					if (prod_child != null) {
						if (cat_children.get(cat_i).hasAttributes()) {
							cat_name = cat_children.get(cat_i).getAttribute("name");
							cat_type = cat_children.get(cat_i).getAttribute("type");
						}
						List<Element> list = null;
						
						
						if (cat_type != null)
							xmltype = XMLType.valueOf(cat_type.getValue());
						
						String prod_value = prod_child.getText();
						
						
						if(xmltype == XMLType.description && 
								(display == DisplayType.all || display == DisplayType.essential  || display == DisplayType.description)) {
							if (cat_name != null) {
								XMLMap.get(xmltype).add(cat_name.getValue());
							}
							XMLMap.get(xmltype).add(prod_value);
							
						}else if(xmltype == XMLType.text && 
								(display == DisplayType.all || display == DisplayType.nonessential  || display == DisplayType.text)) {
							if (cat_name != null) {
								XMLMap.get(xmltype).add(cat_name.getValue());
							}
	
							XMLMap.get(xmltype).add(prod_value);
	
						}else if (xmltype == XMLType.list && 
								(display == DisplayType.all || display == DisplayType.nonessential  || display == DisplayType.list)) {
							if (cat_name != null) {
								XMLMap.get(xmltype).add(cat_name.getValue());
							}

							list =prod_child.getChildren("item");
							for (int list_i = 0; list_i < list.size(); list_i++) {
								String item = list.get(list_i).getText();
								XMLMap.get(xmltype).add(item);
							}
							
						}else if (xmltype == XMLType.list_numbered && 
								(display == DisplayType.all || display == DisplayType.nonessential  || display == DisplayType.list_numbered)) {
							if (cat_name != null) {
								XMLMap.get(xmltype).add(cat_name.getValue());
							}
						
							list = prod_child.getChildren("item");
							for (int list_i = 0; list_i < list.size(); list_i++) {
								String item = list.get(list_i).getText();
								XMLMap.get(xmltype).add(item);
							}
							
						}else if (xmltype == XMLType.tag && 
								(display == DisplayType.all || display == DisplayType.essential || display == DisplayType.tag)) {
							
							list = prod_child.getChildren("tag");
							for (int list_i = 0; list_i < list.size(); list_i++) {
								String item = list.get(list_i).getText();
								//Output +=("<a href=\"#\"><span class=\"label label-info\">" + item + "</span></a>");
								XMLMap.get(xmltype).add(item);
							}
							
						}
					}
				}
			}
			} catch (Exception e) {
				return null;
			}
		

			return XMLMap;
	}
	
	public static boolean addCategoryTag(Document XMLDocument, String tagName, String displayName, String type, String searchable) {
		if (!XMLDocument.hasRootElement())
		{
			initializeCategory(XMLDocument);
		}
		Element cat_tag = new Element(tagName);
		cat_tag.setAttribute(new Attribute("name", displayName));
		cat_tag.setAttribute(new Attribute("type", type));
		cat_tag.setAttribute(new Attribute("display", searchable));
		
	 
		XMLDocument.getRootElement().addContent(cat_tag);
		return false;
		
	}
	
	public static boolean initializeCategory(Document XMLDocument) {
		Element category = new Element("category");
		if (!XMLDocument.hasRootElement())
		{
			XMLDocument.setRootElement(category);
			/*---- Fill With Essential Tags ---*/
			Element desc_tag = new Element("description");
			desc_tag.setAttribute(new Attribute("name", "Description"));
			desc_tag.setAttribute(new Attribute("type", "description"));
			XMLDocument.getRootElement().addContent(desc_tag);
			Element tags_tag = new Element("tags");
			tags_tag.setAttribute(new Attribute("type", "tag"));
			XMLDocument.getRootElement().addContent(tags_tag);
			return true;
		}
		return false;
	}
	
	public static boolean initializeProduct(Document XMLDocument) {
		Element product = new Element("product");
		if (!XMLDocument.hasRootElement())
		{
			XMLDocument.setRootElement(product);
			/*---- Fill With Essential Tags ---*/
			Element desc_tag = new Element("description");
			XMLDocument.getRootElement().addContent(desc_tag);
			Element tags_tag = new Element("tags");
			XMLDocument.getRootElement().addContent(tags_tag);
			return true;
		}
		return false;
	}
	
	public static Map<String, Element> getCategoryTagMap(Document catXML) {
		List<Element> categoryChildren = catXML.getRootElement().getChildren();
		Map<String, Element> map = new HashMap<String, Element>();
		for (int x = 0; x < categoryChildren.size(); x++) {
			System.err.println(categoryChildren.get(x).getAttribute("type").getValue());
			map.put(categoryChildren.get(x).getName(), categoryChildren.get(x));
		}
		return map;
	}
	
	public static boolean addProductDescription(Document categoryXML, Document productXML, String tagName, String itemValue){
		
		Element root = productXML.getRootElement();
		Element cat_root = categoryXML.getRootElement();
		XMLType xmltype;
		if (!productXML.hasRootElement()) {
			initializeProduct(productXML);
		}
		if (root.getChild(tagName) != null) {
			Element fillIn = root.getChild(tagName);
			xmltype = XMLType.valueOf(cat_root.getChild(tagName).getAttribute("type").getValue());
			if (xmltype != XMLType.list && xmltype != XMLType.list_numbered && xmltype != XMLType.tag)
				fillIn.setText(itemValue);
			else if (xmltype == XMLType.list || xmltype == XMLType.list_numbered){
				Element newItem = new Element("item");
				newItem.setText(itemValue);
				fillIn.addContent(newItem);
			}else if (xmltype == XMLType.tag){
				Element tagItem = new Element("tag");
				tagItem.setText(itemValue);
				fillIn.addContent(tagItem);
				
			}
			return true;
		}else if (cat_root.getChild(tagName) != null) {
			Element newTag = new Element(tagName);
			xmltype = XMLType.valueOf(cat_root.getChild(tagName).getAttribute("type").getValue());
			if (xmltype != XMLType.list && xmltype != XMLType.list_numbered && xmltype != XMLType.tag)
				newTag.setText(itemValue);
			else if (xmltype == XMLType.list || xmltype == XMLType.list_numbered){
				Element newItem = new Element("item");
				newItem.setText(itemValue);
				newTag.addContent(newItem);
			}else if (xmltype == XMLType.tag){
				Element tagItem = new Element("tag");
				tagItem.setText(itemValue);
				newTag.addContent(tagItem);
			}
			root.addContent(newTag);
			return true;
		}
		return false;
	}

}
