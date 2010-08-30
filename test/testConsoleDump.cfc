component extends="mxunit.framework.TestCase"{

	public void function setup(){
		variables.consoleDump = new cfconsole.cfc.consoleDump(); 
		//FileWrite(ExpandPath("./actual.txt"), actual);
	}  

	public void function testString(){
		var expected = "Yo!";
		var itemToTest = "Yo!";  
		var actual = variables.consoleDump.dump(itemToTest);
		AssertEquals(expected,actual);
	}

	public void function testArray13Items(){
		var expected = FileRead(ExpandPath('./examples/array13ItemsResults.txt'));
		var itemToTest = ["a","b","c","d","e","f","g","h","i","j","k","l","m"];  
		var actual = variables.consoleDump.dump(itemToTest);
		AssertEquals(expected,actual);
	}
	
	public void function testArray01Item(){
		var expected = FileRead(ExpandPath('./examples/array01ItemResults.txt'));
		var itemToTest = ["a"];  
		var actual = variables.consoleDump.dump(itemToTest);
		AssertEquals(expected,actual);
	}    
	
	public void function testStruct03Items(){
		var expected = FileRead(ExpandPath('./examples/struct03ItemsResults.txt'));
		var itemToTest = {long="1",longer="2",longest="3"};  
		var actual = variables.consoleDump.dump(itemToTest);
		AssertEquals(expected,actual);
	} 
	
	public void function testStruct07Items(){
		var expected = FileRead(ExpandPath('./examples/struct07ItemsResults.txt'));
		var itemToTest = {long="1",longer="2",longest="3",short="5",shorter="fsdfsdfsdf",shortest="sadsadasfasfasgfasgga",medium="gigity"};  
		var actual = variables.consoleDump.dump(itemToTest);
		AssertEquals(expected,actual);
	} 

}