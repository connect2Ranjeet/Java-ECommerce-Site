$(document).ready(function() {
	
//username validation method
jQuery.validator.addMethod("username", function(username, element){
	return this.optional(element) || username.match(/^[a-zA-Z][a-zA-Z0-9_]{0,19}$/);
}, "Please use only leters and numbers");

//password validation method
jQuery.validator.addMethod("password", function(password,element){
	return this.optional(element) || password.match(/^[a-zA-Z0-9_!@#$%^&*()]{6,}$/);
}, "Please use only standard characters");

//zip code validation method
jQuery.validator.addMethod("postalcode", function(postalcode, element) {
	return this.optional(element) || postalcode.match(/(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXYabceghjklmnpstvxy]{1}\d{1}[A-Za-z]{1} ?\d{1}[A-Za-z]{1}\d{1})$/);
}, "Please specify a valid zip code");

//address validation method
jQuery.validator.addMethod("address", function(address, element) {
	return this.optional(element) || address.match(/^[#-.?!,;:() A-Za-z0-9] ?([-.?!,;:() A-Za-z0-9]|[#-.?!,;:() A-Za-z0-9] )*[#-.?!,;:() A-Za-z0-9]$/);
}, "Please specify a valid address");

//city validation method
jQuery.validator.addMethod("city", function(city,element){
	return this.optional(element) || city.match(/^[a-zA-z] ?([a-zA-z]|[a-zA-z] )*[a-zA-z]$/);
}, "Please specify a valid city");

//phone number validation method
jQuery.validator.addMethod("phoneUS", function(phone_number, element) {
    phone_number = phone_number.replace(/\s+/g, ""); 
	return this.optional(element) || phone_number.length > 9 &&
		phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/);
}, "Please specify a valid phone number");

//change equalTo message
$.validator.messages.equalTo = 'Your passwords do not match';

$('#signup-form').validate({
    rules: {
    	inputName: {
    		minlength:3,
    		required: true
    	},
      inputUsername: {
        minlength: 2,
        maxlength: 20,
        username: true,
        required: true
      },
      inputEmail: {
	        required: true,
	        email: true
	  },
	  inputPassword: {
		  	password: true,
	        required: true,
	        minlength:6
	  },
	  inputRePassword: {
		  	required: true,
	        equalTo: "#inputPassword",
	        minlength:6
	  },
	  inputAddress1: {
	        required: true,
	        address: true
	  },
	  inputAddress2: {
		  	address: true
	  },
	  inputCity: {
	        required: true,
	        city: true
	  },	  
	  inputZipcode: {
	        postalcode: true,
	        required: true
	  },
	  inputCountry: {
	        required: true
	  },	  
	  inputState: {
	        required: true
	  },
	  inputPhone:{
		   	phoneUS: true
	  }
    },
    
    highlight: function(label) {
    	$(label).closest('.control-group').addClass('error');
    },
    
    success: function(label) {
    	label
    		.text(' Correct !').addClass('valid')
    		.closest('.control-group').addClass('success');
    }
  });
  
});