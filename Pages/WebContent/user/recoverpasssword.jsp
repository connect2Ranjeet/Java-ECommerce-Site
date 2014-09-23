<jsp:include page="/layout/header.jsp" flush="true" />

<div class="well" style="width: 440px; margin: 0 auto;">

	<form class="form-horizontal" action="/">
		<h3>Recover password</h3>
		<div class="control-group">
			<label class="control-label" for="inputEmail">Email</label>
			<div class="controls">
				<input type="text" id="inputEmail" placeholder="Email">
			</div>
		</div>
		
		<div class="control-group">
			<div class="controls">
				<button type="submit" class="btn btn-primary">Send</button>
			</div>
		</div>
	</form>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />