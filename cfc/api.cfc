component 
{

	public struct function callCode(required string code, required string username, required string password){
		var result = {};
		result.result = "";
		result.error = "";
		result.success = false;
		
		if (not auth(arguments.username, arguments.password)){
			result.error = "Authentication Failed";
			return result;
		}
		
		var cfconsole = new cfconsole();
		result.result = cfconsole.runCode (arguments.code,isCFML(arguments.code)); 
		result.success = true;
		return result;
	}
	
	private boolean function auth(required string username, required string password){
		return true;
	}
	
	private boolean function isCFML(required string code){
		if (FindNoCase("<CF", arguments.code)){
			return true;
		}
		else{
			return false;
		}
	
	}
	
	 

}