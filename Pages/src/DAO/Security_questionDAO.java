/** Deferred **/

package DAO;

public abstract class Security_questionDAO extends DatabaseObject{
	private static final String name = "Security_question";

	public Security_questionDAO(){
		super();
	}
	
	public String getName() {
	   return name;
	}
}