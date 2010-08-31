component{

	public struct function onIncomingMessage(required struct incomingMessage){
		var outGoingMessage = {};
		writeDump(arguments.incomingMessage, "console");
		
		
		
		if (not session.loggedin){
			if (not session.logininProgress){
				outgoingMessage = usernamePrompt();
			}
			else if (FindNoCase("username", session.loginStep)){
				session.username = incomingMessage.data.message;
				outgoingMessage = passwordPrompt();
			}
			else if (FindNoCase("password", session.loginStep)){
				session.password = incomingMessage.data.message;
				outgoingMessage = auth();
			}
		}
		else{
			outgoingMessage = runcode(incomingMessage.data.message);
		}
		
		writeDump(session, "console");	
		return outGoingMessage;
	}
	
	public struct function usernamePrompt(){
		var outGoingMessage = {};
		outGoingMessage.message = "Username:";
		session.logininprogress = true;
		session.loginstep= "username";
		return outGoingMessage;
	}
	
	public struct function passwordPrompt(){
		var outGoingMessage = {};
		outGoingMessage.message = "Password:";
		session.logininprogress = true;
		session.loginstep= "password";
		return outGoingMessage;
	}
	
	public struct function auth(){
		var outGoingMessage = {};
		
		var api = new cfconsole.cfc.api();
		var isAuth = api.auth(session.username,session.password);
		
		if (isAuth){
			outGoingMessage = welcomePrompt();
			session.loggedin = true;
		}
		else{
			outGoingMessage = authFailPrompt();
		}
		 
		
		return outGoingMessage;
	}
	
	public struct function welcomePrompt(){
		var outGoingMessage = {};
		outGoingMessage.message = "You have logged in";
		session.logininprogress = false;
		session.loginstep= "";
		return outGoingMessage;
	}
	
	public struct function authFailPrompt(){
		var outGoingMessage = {};
		outGoingMessage.message = "Authentication Failed\nUsername:";
		session.logininprogress = true;
		session.loginstep= "username";
		return outGoingMessage;
	}
	
	public struct function runCode(required string codeToCall){
		var outGoingMessage = {};
		var api = new cfconsole.cfc.api();
		var result = api.callCode(arguments.codeToCall,session.username,session.password); 	
		
		outGoingMessage.message = result.result;
		
		return outGoingMessage;
	}
}