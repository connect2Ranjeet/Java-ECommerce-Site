package Database;
public class Validation {
	/** A set of String variables to be used for RegEx matches **/
	private static String usernamePattern = "[a-zA-Z][a-zA-Z_0-9]+";
	private static String passwordPattern = "[zA-Z0-9_!@#$%^&*()]+";
	private static String emailPattern = "[^@]*[^@.]@[^@]+\\.[^@]+";
	
	/** 
	 * Validates username inputs
	 * @param username An input username string to test for validity
	 * @return A boolean indicating whether the username input was valid
	 **/
	public static boolean validateUsername(String username){
		if(username == null){return false;}
		int inputLength = username.length();
		if(inputLength == 0 || inputLength > 20){
			return false;
		}
		return username.matches(usernamePattern);
	}
	
	/**
	 * Validates password inputs
	 * @param password An input password string to test for validity
	 * @return A boolean indicating whether the password input was valid
	 **/
	public static boolean validatePassword(String password){
		if(password == null){return false;}
		int inputLength = password.length();
		if(inputLength < 6){
			return false;
		}
		return password.matches(passwordPattern);
	}
	
	/**
	 * Validates email inputs
	 * @param email An input email string to test for validity
	 * @return A boolean indicating whether the email input was valid
	 **/
	public static boolean validateEmail(String email){
		if(email == null){return false;}
		int inputLength = email.length();
		if(inputLength < 6){
			return false;
		}
		return email.matches(emailPattern);
	}
}