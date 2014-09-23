$(document).ready(
		function() {
			
			var product_view = ReadCookie("product_view");
			if(product_view!=null){
				if(product_view=="0"){
					$("#view-list").hide();
					$("#view-grid").show();	
					$("#product-view-grid").addClass("active");
					$("#product-view-list").removeClass("active");
				}else{
					$("#view-list").show();
					$("#view-grid").hide();
					$("#product-view-grid").removeClass("active");
					$("#product-view-list").addClass("active");					
				}
				
			}else{
				/// default view
				SetCookie("product_view","0",60); /// 0 is grid view
			}
			
			$("#product-view-grid").click(function() {
				$("#view-list").hide();
				$("#view-grid").show();
				SetCookie("product_view","0",60); /// 0 is grid view
			});

			$("#product-view-list").click(function() {
				$("#view-list").show();
				$("#view-grid").hide();
				SetCookie("product_view","1",60); //// 1 is list view
			});
			
			
			/**
			 * When scrolled all the way to the bottom, add more tiles.
			 */
			/*
			function onScroll(event) {
			  // Check if we're within 100 pixels of the bottom edge of the broser window.
			  var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
			  if(closeToBottom) {
			    // Get the first then items from the grid, clone them, and add them to the bottom of the grid.
			    var items = $('#view-grid li');
			    var firstTen = items.slice(0, 10);
			    $('#view-grid').append(firstTen.clone());
			    
			    // Clear our previous layout handler.
			    if(handler) handler.wookmarkClear();
			    
			    // Create a new layout handler.
			    handler = $('#view-grid li');
			    handler.wookmark(options);
			  }
			};
			 */

			//$(document).bind('scroll', onScroll);


		});
