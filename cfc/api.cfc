component 
{

	remote struct function callCode(required string code, required string username, required string password){
		writeLog("API Called: code =" & arguments.code);
		var prefix = "";
		var suffix = "";
		var codeToCall = "";
		var result = {};
		result.result = "";
		result.error = "";
		result.success = false;
		
		if (not auth(arguments.username, arguments.password)){
			result.error = "Authentication Failed";
			return result;
			writeLog("API Failed");
		}
		
		if (not isCFML(arguments.code) and not Find("=", arguments.code)){
			prefix = "resultToDisplay = ";
		}
		
		if (not isCFML(arguments.code) and not Find(";", arguments.code)){
			suffix = ";";
		}
		codeToCall = prefix & arguments.code & suffix;
		var cfconsole = new cfconsole();
		result.result = cfconsole.runCode (codeToCall,isCFML(arguments.code)); 
		result.success = true;
		writeLog("API Success result = " & result.result);
		
		return result;
	}
	
	public boolean function auth(required string username, required string password){
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