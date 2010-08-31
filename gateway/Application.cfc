component{
	This.name = "CFConsoleTelnetClient";
	This.sessionManagement = true;
	This.mappings["cfconsole"] = ExpandPath("../");
	
	
	public boolean function onSessionStart(){
		session.loggedin = false;
		session.username = "";
		session.password = "";
		session.logininprogress = false;
		session.loginstep = "";
		return true;
	}

}