

<jsp:include page="/management/layout/header.jsp" flush="true" />
<%@ page import="XML.XMLParser"%>
<%@ page import="XML.XMLParser.XMLType"%>
<%@ page import="java.util.*"%>
<%@ page import="Action.CategoryAction"%>
<%@ page import="Action.ProductAction"%>
<%@ page import="Action.ImageAction"%>
<%@ page import="org.jdom2.Attribute"%>
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.output.Format"%>
<%@ page import="org.jdom2.output.XMLOutputter"%>
<!-- JAVASCRIPT FUNCTIONS -->
<script >
    function function1(object, txtobj) {
        var newOption = document.createElement("option");
        object.options.add(newOption);
        newOption.text = txtobj.value;
	newOption.value = txtobj.value;
	txtobj.value='';
    }
    function function2(object) {
        object.options.remove(object.selectedIndex);
    }
    function selectAll(classname) {
    	var elements = document.getElementsByClassName(classname);
    	for (var i =0; i<elements.length; i++) {
    		for (var j=0; j<elements[i].options.length; j++){
    			elements[i].options[j].selected=true;
    		}
    	}
    }
</script>


<%

	String categoryID = request.getParameter("cat");
	String catXMLNames[] = null;
	Document newXML = new Document(); 
	Document catXML = null;
	Map<String, Element> catXMLMap = null;
	Map<String, List<String>> catMap = CategoryAction.getCategoryMap();
	String product_url = (String)session.getAttribute("product_url");
	if (categoryID != null) {
		catXML = CategoryAction.getXMLDocumentByID(Integer.parseInt(categoryID));
		catXMLMap = XMLParser.getCategoryTagMap(catXML);
		catXMLNames = new String[catXMLMap.keySet().size()];
		catXMLMap.keySet().toArray(catXMLNames);
		System.err.println(catXMLMap);
	}
%>
<%
if (request.getMethod().compareTo("POST") == 0 && request.getParameter("add_product") != null) {
	XMLParser.initializeProduct(newXML);
	for (int x = 0; x < catXMLNames.length; x++) {
		String list_temp[] = request.getParameterValues(catXMLNames[x]+"List");
		if (list_temp != null && list_temp.length > 0) {
			for (int y=0; y<list_temp.length;y++){
				XMLParser.addProductDescription(catXML, newXML, catXMLNames[x], list_temp[y]);
			}
		}
		if (request.getParameter(catXMLNames[x] + "Text") != null && request.getParameter(catXMLNames[x] + "Text").length() > 0)
			XMLParser.addProductDescription(catXML, newXML, catXMLNames[x], request.getParameter(catXMLNames[x] + "Text"));
	}
	String productPrice = request.getParameter("productPrice");
	String productName = request.getParameter("productName");
	int prodPrice = (int)(Double.parseDouble(productPrice) * 100);
	String productQuantity = request.getParameter("productQuantity");
	XMLOutputter xmlOutput = new XMLOutputter();
	xmlOutput.setFormat(Format.getPrettyFormat());
	String output = xmlOutput.outputString(newXML);
	
	
	int newImage_ID =0;
	int newDesc_ID =0;
	int catDesc_ID=0;
	int prodDesc_ID =0;
	int newProd_ID = 0;
	if (product_url != null) {
		newProd_ID = ProductAction.addProduct(productName, Integer.toString(prodPrice), productQuantity, "1", categoryID);	
	}else{
		%> 
		<script type="text/javascript">
		<!--
		self.location='add.jsp?error=1';
		//-->
		</script>
		<%
		return;
	}
	
	if (newProd_ID > 0) {
		ImageAction.addImage(product_url, Integer.toString(newProd_ID));
		catDesc_ID = CategoryAction.getCategoryDescID(categoryID);
		prodDesc_ID = ProductAction.addProductDescription(output, Integer.toString(catDesc_ID), Integer.toString(newProd_ID));
	}else{
		%> 
		<script type="text/javascript">
		<!--
		self.location='add.jsp?error=2';
		//-->
		</script>
		<%
		return;
	}
	
	if (prodDesc_ID > 0 && catDesc_ID > 0) {
		session.removeAttribute("product_url");
		%> 
		<script type="text/javascript">
		<!--
		self.location='list.jsp';
		//-->
		</script>
		<%
		return;
	}else {
		%> 
		<script type="text/javascript">
		<!--
		self.location='add.jsp?error=3';
		//-->
		</script>
		<%
		return;
	}
}

if (request.getMethod().compareTo("POST") == 0 && request.getParameter("add_product") == null ) {
	product_url = ImageAction.uploadImage(request, response);
	session.setAttribute("product_url", product_url);
	System.err.println(product_url);
}




%>

<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li class="active"><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<h3>Add Product</h3>
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div class="btn-group">
					<a href="/management/product/list.jsp" class="btn btn-inverse">Back</a>
				</div>
			</div>
			
			
			<div class="row-fluid">
				<div class="well">
				<% if (request.getParameter("error") != null && request.getParameter("error").compareTo("1")==0) { %>
				<div class="alert alert-error">You must upload a product image!</div>
  				<%}else if(request.getParameter("error") != null && request.getParameter("error").compareTo("2")==0) { %>
  				<div class="alert alert-error">This Product Name already exists!</div>	
  				<%}else if(request.getParameter("error") != null && request.getParameter("error").compareTo("3")==0) { %>
  				<div class="alert alert-error">Product Description contains errors!</div>	
  				<%} %>
					<div>
						
							<div class="control-group">
							<% if (categoryID == null) { %>
				
							<label class="control-label" for="categorySelect">Select a Category:</label>
							<div class="controls">
								<div class="input-prepend">
				  					<div class="btn-group">
				  					<button class="btn dropdown-toggle" data-toggle="dropdown">
				   					Categories
				   					<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
									<% for (int x=0; x< catMap.get("ID").size(); x++) { %>
										<li><a tabindex="-1" href="?cat=<%= catMap.get("ID").get(x)%>"><%=catMap.get("Name").get(x)%></a></li>
									<%} %>
									</ul>
									</div>
									<input id="prependedDropdownButton" type="text" name="categorySelect" placeholder="Select A Category" disabled>
								</div>
								</div>
							<% } else { %>
								
								<label class="control-label" for="categorySelect">Select a Category:</label>
							<div class="controls">
								<div class="input-prepend">
				  					<div class="btn-group">
				  					<button class="btn dropdown-toggle" data-toggle="dropdown" disabled>
				   					<%=catMap.get("Name").get(catMap.get("ID").indexOf(categoryID))%>
				   					<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
									</ul>
									</div>
									<input id="prependedDropdownButton" type="text" name="categorySelect" placeholder="Category Selected" disabled>
								</div>
								</div>
								
							<%}	%>
							</div>
							</div>
							
							<% if (categoryID!=null) { %>
							<div class="control-group">
							<div class="controls">
							<div class="alert">
								<h5>Product Image</h5>
								<form method="post" enctype="multipart/form-data">
								<% if (product_url == null) { %>
								<input type="file" name="photo" required>
								<button type="submit" class="btn">Upload</button>
								<%}else { %>
								<a href="javascript:window.open('<%=product_url%>','Product Image');"><img src="<%=product_url%>" style ="max-height: 80px; width: auto;height: 80px;"/></a>
								<input type="file" name="photo" value="Picture Chosen" disabled>
								<button type="submit" class="btn" disabled>Upload</button>
								<%} %>
								</form>
								<form class="form-horizontal" method="POST" onsubmit="selectAll('list');">
								<input type="hidden" name="add_product" value="1" />
							</div>
							</div>
							</div>
							<div class="row-fluid">
							<div>
							<h5>Product Description</h5>
							<hr/>
							<!-- TEXT ENTRY -->
							<div class="alert offset1">
							<div class="input-prepend input-append">
							<h5>Product Specifications</h5>
								<div class="control-group">
									<label class="control-label" for="productPrice">Product Name:</label>
									<div class="controls">
									<input type="text" placeholder="Product Name" name="productName" required>
									</div>
									<label class="control-label" for="productPrice">Product Price:</label>				
									<div class="controls">
									<span class="add-on">$</span>
									<input id="appendedPrependedInput"  name="productPrice" type="text" required>
									</div>
									<label class="control-label" for="productQuantity">Product Quantity:</label>
									<div class="controls">
									<input type="number" name="productQuantity" min="-1" max="999" value="1" required>
									</div>
								
								</div>
							</div>
							</div>
							<div class="alert alert-info offset1">
							<h5>Description</h5>
							<div class="control-group">
													
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
									    
								</div>
								
							</div>
							<div class="control-group">
													
							<div class="controls">
							<textarea rows="5" class="input-xxlarge" name="descriptionText" placeholder="Product Description" required></textarea>
							</div>
								
							</div>
							</div>
							<!-- LISTS -->
							<div class="alert alert-info offset1">
							<h5>Tags</h5>
							<div class="control-group">
									
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
									    
								</div>
								</div>
								
							<div class="control-group">
													
							<div class="controls">
							<select multiple="multiple" name="tagsList" class="list"></select>
							</div>
								
							</div>
							
							<div class="control-group">
													
							<div class="controls">
							<div class="input-append">
							<input id="appendedInputButton" type="text" name ="tagText">
							<button  type="button" class="btn btn-primary" onclick="function1(tagsList, tagText);">Add</button>
							<button  type="button" class="btn btn-danger" onclick="function2(tagsList);">Remove</button>
							</div>
							</div>
								
							</div>
							</div>	
							<!--  NON-ESSENTIALS -->
							<%
							String curr_name = null;
							for (int x=0; x< catXMLNames.length; x++){
								XMLType curr_type = XMLType.valueOf(catXMLMap.get(catXMLNames[x]).getAttribute("type").getValue());
								Attribute name_temp = catXMLMap.get(catXMLNames[x]).getAttribute("name");
								if (name_temp != null)
									curr_name = name_temp.getValue(); 
								if (curr_type == XMLType.list || curr_type == XMLType.list_numbered) {
									%>
										<!-- LISTS -->
										<div class="alert alert-info offset1">
										<h5><%=curr_name%></h5>
										<div class="control-group">
												
										<div class="controls">
											
												    <div class="input-prepend">
												    <div class="btn-group">
												    <button class="btn dropdown-toggle" data-toggle="dropdown" disabled>
												    <%=curr_type.toString().toUpperCase()%>
												    <span class="caret"></span>
												    </button>
												    <ul class="dropdown-menu">
												    </ul>
												    </div>
												    <input id="prependedDropdownButton" type="text"  placeholder="<%=curr_name%>" disabled>
												    </div>
												    
											</div>
											</div>
											
										<div class="control-group">
																
										<div class="controls">
										<select multiple="multiple" name="<%=catXMLNames[x]%>List" class="list"></select>
										</div>
											
										</div>
										
										<div class="control-group">
																
										<div class="controls">
										<div class="input-append">
										<input id="appendedInputButton" type="text" name ="<%=catXMLNames[x]%>Text">
										<button  type="button" class="btn btn-primary" onclick="function1(<%=catXMLNames[x]%>List, <%=catXMLNames[x]%>Text);">Add</button>
										<button  type="button" class="btn btn-danger" onclick="function2(<%=catXMLNames[x]%>List);">Remove</button>
										</div>
										</div>
											
										</div>
										</div>
									<%
								}else if (curr_type == XMLType.text){
									%>
									<!-- TEXT ENTRY -->
									<div class="alert alert-info offset1">
									<h5><%=curr_name%></h5>
									<div class="control-group">
															
									<div class="controls">
										
											    <div class="input-prepend">
											    <div class="btn-group">
											    <button class="btn dropdown-toggle" data-toggle="dropdown" disabled>
											    <%=curr_type.toString().toUpperCase()%>
											    <span class="caret"></span>
											    </button>
											    <ul class="dropdown-menu">
											    </ul>
											    </div>
											    <input id="prependedDropdownButton" type="text"  placeholder="<%=curr_name%>" disabled>
											    </div>
											    
										</div>
										
									</div>
									<div class="control-group">
															
									<div class="controls">
									<textarea rows="3" name="<%=catXMLNames[x]%>Text" placeholder="Product <%=curr_name%>"></textarea>
									</div>
										
									</div>
									</div>
									<%
								}
									
								
							}
							%>
							
							
								</div>
							 
							
							</div>
							<% } %>
							</div>
							<div class="row-fluid">
							<div class="span5"><br><br>
							<div class="control-group">
								<div class="controls">
									<button type="submit" class="btn btn-primary">Add Product</button>
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