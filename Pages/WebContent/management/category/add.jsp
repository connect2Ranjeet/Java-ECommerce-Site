<jsp:include page="/management/layout/header.jsp" flush="true" />
<%@ page import="XML.XMLParser"%>
<%@ page import="XML.XMLParser.XMLType"%>
<%@ page import="java.util.*"%>
<%@ page import="Action.CategoryAction"%>
<%@ page import="org.jdom2.Attribute"%>
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.output.Format"%>
<%@ page import="org.jdom2.output.XMLOutputter"%>
<%
XMLType xmltypes[] = XMLType.values();
Document newXML = new Document();  


List<String> catType = null;

if (session.getAttribute("catType") == null)
	catType = new ArrayList<String>();
else
	catType = (ArrayList<String>)session.getAttribute("catType");


if (request.getMethod().compareTo("POST") == 0) {
	System.out.println("catType size: " + catType.size());
	XMLParser.initializeCategory(newXML);
	String name = request.getParameter("inputCategoryName");
	for (int x=0;x<catType.size();x++) {
		String catName = request.getParameter("inputTagName" + x);
		int cutSpace = catName.indexOf(" ");
		if (cutSpace < 1)
			cutSpace =catName.length();
		String tagName = catName.substring(0, cutSpace).toLowerCase();
		XMLParser.addCategoryTag(newXML, tagName, catName, catType.get(x), "0");
	}
	
	XMLOutputter xmlOutput = new XMLOutputter();
	xmlOutput.setFormat(Format.getPrettyFormat());
	String output = xmlOutput.outputString(newXML);
	
	if (name.length() < 1) {
		session.removeAttribute("catType");
		response.sendRedirect("add.jsp?error=1");
		return;
	}
		
	int newCat_ID = CategoryAction.addCategory(name);
	if (newCat_ID < 1)
	{
		session.removeAttribute("catType");
		response.sendRedirect("add.jsp?error=1");
		return;
	}else{
		CategoryAction.addCategoryDescription(output, newCat_ID);  
		session.removeAttribute("catType");
		response.sendRedirect("list.jsp");
		return;
	}
		
}



if (request.getParameter("add_type") != null) {
	catType.add(request.getParameter("add_type"));
	session.setAttribute("catType", catType);

}
	
if (request.getParameter("reset") != null && request.getParameter("reset").compareTo("1")==0){
	catType.clear();
	session.setAttribute("catType", catType);

}



%> 
<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li class="active"><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<h3>Add category</h3>
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div class="btn-group">
					<a href="/management/category/list.jsp" class="btn btn-inverse">Back</a>
				</div>
			</div>
			<form class="form-horizontal" method="POST">
			<div class="row-fluid">
				<div class="well">
				<% if (request.getParameter("error") != null && request.getParameter("error").compareTo("1")==0) { %>
				<div class="alert alert-error">This Category Name is Not Correct!</div>
  				<%} %>
					<div>
						
							<div class="control-group">
								<label class="control-label" for="inputCategoryName">Name</label>
								<div class="controls">
									<input type="text" id="inputCategoryName" name = "inputCategoryName"  placeholder="Name" required>
								</div>
							</div>
							</div>
							
							<div class="row-fluid">
							<div>
							<h5>Category Description</h5>
							<hr/>
							
							<div class="control-group">
							<label class="control-label" for="inputTagName">Default Tag:</label>
							
							<div class="controls">
								
									    <div class="input-prepend">
									    <div class="btn-group">
									    <button class="btn dropdown-toggle" data-toggle="dropdown" disabled>
									    DESCRIPTION
									    <span class="caret"></span>
									    </button>
									    <ul class="dropdown-menu">
									    </ul>
									    </div>
									    <input id="prependedDropdownButton" type="text"  placeholder="Description" disabled>
									    </div>
									    <label class="checkbox inline">
  								<input type="checkbox" id="inlineCheckbox1" value="option1" checked="true" disabled> Searchable
								</label>
								</div>
								
							</div>
							<div class="control-group">
							<label class="control-label" for="inputTagName">Default Tag:</label>
							
							<div class="controls">
								
									    <div class="input-prepend">
									    <div class="btn-group">
									    <button class="btn dropdown-toggle" data-toggle="dropdown" disabled>
									    TAG
									    <span class="caret"></span>
									    </button>
									    <ul class="dropdown-menu">
									    </ul>
									    </div>
									    <input id="prependedDropdownButton" type="text"  placeholder="None" disabled>
									    </div>
									    <label class="checkbox inline">
  								<input type="checkbox" id="inlineCheckbox1" value="option2" checked="true" disabled> Searchable
								</label>
								</div>
								
							</div>	
							<%
							if (catType.size() > 0) {
							
							for (int x=0; x<catType.size(); x++)
							{
								
							out.print("<div class=\"control-group\"><label class=\"control-label\" for=\"inputTagName" + x
							+ "\">New Tag Name:</label><div class=\"controls\"><div class=\"input-prepend\"><div class=\"btn-group\"><button class=\"btn dropdown-toggle\" data-toggle=\"dropdown\" disabled>" + catType.get(x).toUpperCase()
							+ "<span class=\"caret\"></span></button><ul class=\"dropdown-menu\">");
							out.print ("</ul></div><input id=\"prependedDropdownButton\" type=\"text\" name = \"inputTagName"+x+"\" placeholder=\"Tag Name\" required></div></div></div>");
							}
							}
							%>
							
							<div class="controls">
								
									    <div class="input-prepend">
									    <div class="btn-group">
									    <button class="btn dropdown-toggle" data-toggle="dropdown">
									    Add Tag
									    <span class="caret"></span>
									    </button>
									    <ul class="dropdown-menu">
										<% 
									    
									    for (int x=0; x<xmltypes.length;x++){
									    	if (xmltypes[x] != XMLType.description && xmltypes[x] != XMLType.tag){
									    	out.print("<li><a tabindex=\"-1\" href=\"?add_type="+xmltypes[x].toString()+ "\">" +
									    		xmltypes[x].toString().toUpperCase() + "</a></li>");
									    	}
									    }
									    %>
									    </ul>
									    </div>
									    <input id="prependedDropdownButton" type="text" name = "inputTagName"  placeholder="Tag Name">
									    </div>
									</div>
								</div>
							 
							
							</div>
							</div>
							<div class="row-fluid">
							<div class="span5"><br><br>
							<div class="control-group">
								<div class="controls">
									<button type="submit" class="btn btn-primary">Add Category</button>
								</div>
								
							</div>
							</div>
							</form>
							<div>
							<br><br>
							<form>
							<div class="control-group">
								<div class="controls">
									<button type="button" onClick="self.location='?reset=1'" class="btn btn-danger">Reset</button>
								</div>
							</div>
							</form>
							</div>
							</div>
							
							</div>
							
							
							
						
					</div>
					
					
				
				
							
<jsp:include page="/management/layout/footer.jsp" flush="true" />