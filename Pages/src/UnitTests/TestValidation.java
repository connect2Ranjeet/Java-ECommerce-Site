package UnitTests;

import java.lang.reflect.*;

import Database.Validation;

public final class TestValidation {

	/**
	 * Runs all the validation tests in sequence
	 * @param args Main input strings
	 */
	public static void main(String[] args) {
		try{
			Class<?> c = TestValidation.class;
			Method m[] = c.getDeclaredMethods();
			Method mi;
			for (int i = 0; i < m.length; i++){
				mi = m[i];
				if(mi.getName().startsWith("test")){
					if(mi.getReturnType().equals(boolean.class)){
						if(mi.invoke(null).equals(false)){
							System.out.println(mi.getName() + " failed");
						}
					}
				}
			}
		}catch(Throwable e){
			System.err.println(e);
		}
	}
	/** Tests for validateUsername **/
	public static boolean testNull_ValidateUsername(){
		return !Validation.validateUsername(null);
	}
	public static boolean testLength_ValidateUsername(){
		return (!Validation.validateUsername("") &&
				!Validation.validateUsername("a23456789012345678901") &&
				Validation.validateUsername("a234567890"));
	}
	public static boolean testInvalid_ValidateUsername(){
		return (!Validation.validateUsername("a234567890~") &&
				!Validation.validateUsername("a234567890<") &&
				!Validation.validateUsername("1234567890") &&
				!Validation.validateUsername("_234567890"));
	}
	/** Tests for validatePassword **/
	public static boolean testNull_ValidatePassword(){
		return !Validation.validatePassword(null);
	}
	public static boolean testLength_ValidatePassword(){
		return (!Validation.validatePassword("") &&
				!Validation.validatePassword("12345") &&
				Validation.validatePassword("12345678"));
	}
	
}