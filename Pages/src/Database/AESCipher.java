package Database;
/*
 * 
 * 		This file adds AES ecryption/decription abilities to our database connection.  It is static with respect to SOL and the system.
 * 		
 * 		extended by: conSOL
 * 
 */

import javax.crypto.*;
import javax.crypto.spec.*;
import java.util.Random;
import java.io.UnsupportedEncodingException;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.InvalidParameterSpecException;
import java.security.spec.KeySpec;

public class AESCipher {

	/* Our user generated salt. This will make our password uncrackable by dictionary attacks */
	private static byte[] salt = {(byte)0xcc, (byte)0x7a, (byte)0x11, (byte)0xc,
	        (byte)0xae, (byte)0xd1, (byte)0xe, (byte)0x8};
	
	/* We have to store our IV since Java does not pass by reference */
	private byte[] iv = null;
	
	/* We also require a getter method for our IV so we can store it later */
	public byte[] getIV() {
		return iv;
	}

	/* This will take a char array for our key, a phrase that we want to encrypt, and it will return our encrypted
	 * phrase as a byte array, and it will update iv, our byte array required to decrypt our encrypted phrase.
	 * REMEMBER to store the IV.
	 */
	public byte[] encrypt (char[] key, String phrase) throws NoSuchAlgorithmException,
															InvalidKeySpecException,
															NoSuchPaddingException, 
															InvalidKeyException,
															InvalidParameterSpecException,
															IllegalBlockSizeException,
															BadPaddingException,
															UnsupportedEncodingException {
		/* We generate our keys */
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		KeySpec spec = new PBEKeySpec(key, salt, 65536, 256);
		SecretKey tmp = factory.generateSecret(spec);
		SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");
		/* Encrypt the message. */
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, secret);
		AlgorithmParameters params = cipher.getParameters();
		
		/* We store our IV */
		iv =  params.getParameterSpec(IvParameterSpec.class).getIV();
		
		/* We do our final encryption */
		byte[] ciphertext = cipher.doFinal(phrase.getBytes("UTF-8"));
		return ciphertext;
	}
	
	/* This will take our char array key, our IV generated during encryption and our encrypted phrase,
	 * or ciphertxt. This will then return our unencrypted string.
	 */
	public String decrypt(char[] key, byte[] iv, byte[] ciphertxt) throws UnsupportedEncodingException,
																		IllegalBlockSizeException,
																		BadPaddingException,
																		InvalidKeyException,
																		InvalidAlgorithmParameterException,
																		NoSuchAlgorithmException,
																		NoSuchPaddingException,
																		InvalidKeySpecException {
		
		/* We generate our key*/
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		KeySpec spec = new PBEKeySpec(key, salt, 65536, 256);
		SecretKey tmp = factory.generateSecret(spec);
		SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		/* We pass in our IV from earlier with our key*/
		cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(iv));
		
		/* We decrypt our key */
		String plaintext = new String(cipher.doFinal(ciphertxt), "UTF-8");
		return plaintext;
	}
	
	/*Random password generator. It takes a length and returns a string of that length consisting of a randomized
	 * alphabet.
	 */
	public String secure_string(int length) {
		/*Our string should be sufficiently long. This might be changed later, but I have the minimum set to 50
		 * chars.
		 */
		if (length < 50)
			return null;
		
		/*The alphabet we'll be using. Some characters may not be legal, our randomizer will scale accordingly*/
		String alphabet = "1234567890ABCDEFGHIJKLMNOPQRSTUVabcdefghijklmnopqrstuv`~!@#$%^&*()-_=+;:'\",<.>/?";
		Random rand = new Random();
		String temp = new String();
		
		/*Our randomizer will pick a random index in our alphabet and we'll add the character at that index to our
		 * new string. We'll keep doing this until we reach our desired length.
		 */
		for (int x=0; x < length; x++) {
			temp += alphabet.charAt(rand.nextInt(alphabet.length())); //our max random value is the length of our alphabet
		}
		return temp;
	}

}
