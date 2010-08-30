component{

	public function init(){
    	variables.consoleDump = new consoleDump(); 	
    	return This;
    }
    

 	public string function runCode(required string code, boolean isCFML=false){
		var results = "";
		var dump = "";
		var i = 0;
		
		var tempSpace = GetDirectoryFromPath(getCurrentTemplatePath());
		var tempFileName = createUUID();
		var tempFile = tempSpace & "/" & tempFileName  & ".cfm";
		
		if (arguments.isCFML){
			FileWrite(tempFile, arguments.code);
		}
		else{
			FileWrite(tempFile, "<cfscript>" & arguments.code & "</cfscript>");		
		}	
		
		var pre = duplicate(variables);
		
		savecontent variable="results"{
			include "#tempFileName#.cfm";
		}
		
		var post = duplicate(variables);
		
		var new = whatsnew(pre,post);
		var newKeys = StructKeyArray(new);
		
		savecontent variable="dump"{
			for (i=1; i<= Arraylen(newKeys); i++){
				var temp = variables.consoleDump.dump(new[newKeys[i]]);
				writeOutput(temp);
			}
		}
		
		FileDelete(tempFile);
		
		return results & dump;
	}
	
	private struct function whatsnew(required struct old, required struct new){
		var oldStructKeys = StructKeyArray(old);
		var results = duplicate(new);
		var newStructKeys = StructKeyArray(results);
		var i = 0;
		
		for (i=1; i<= Arraylen(oldstructKeys); i++){
			structDelete(results, oldStructKeys[i]);
		}
		
		for (i=1; i<= Arraylen(newStructKeys); i++){
			if (FindNoCase("___IMPLICIT",newStructKeys[i])){
				structDelete(results, newStructKeys[i]);
			}
		}	
	
		return results;
	}

}