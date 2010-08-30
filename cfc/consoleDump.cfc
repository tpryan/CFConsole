component{

	public function init(){
    	variables.NL = createObject("java", "java.lang.System").getProperty("line.separator");	
    	return This;
    }
	
	public string function dump(required any var){
		var result = [];
	
		if (IsSimpleValue(arguments.var)){
			ArrayAppend(result, arguments.var);
		}
		else if (IsArray(arguments.var)){
			ArrayAppend(result, dumpArray(arguments.var));
		}
		else if (IsStruct(arguments.var)){
			ArrayAppend(result, dumpStruct(arguments.var));
		}
		else if (isQuery(arguments.var)){
			ArrayAppend(result, dumpQuery(arguments.var));
		}	
	
	
		return ArrayToList(result, variables.NL);
	}
	
	public string function dumpQuery(required query queryToDump){
		var result = [];
		var i = 0;
		var j = 0;
		var columnLens = lenOflongestInQueryColumns(arguments.queryToDump);
		var columns = ListToArray(arguments.queryToDump.columnList);
		
		ArrayAppend(result, "Query: " & arguments.queryToDump.recordCount & " records");
		ArrayAppend(result, "--------------------");
		
		//header
		var lineArray = [];
		for (j=1; j <=ArrayLen(columns); j++){
			var column = columns[j];
			ArrayAppend(lineArray, padStr(column,columnLens[column]+1, "left"));
		}
		ArrayAppend(result, ArrayToList(lineArray,""));		
		
		
		for (i=1; i <= arguments.queryToDump.recordcount; i++ ){
			
			var lineArray = [];
			for (j=1; j <=ArrayLen(columns); j++){
				var column = columns[j];
			
				if (isSimpleValue(arguments.queryToDump[column][i])){
					ArrayAppend(lineArray, padStr(arguments.queryToDump[column][i], columnLens[column]+1, "left"));
				}
				else{
					ArrayAppend(lineArray, padStr(dump(columnLens[column]), columnLens[column]+1, "left"));
				}
				
			}	
			ArrayAppend(result, ArrayToList(lineArray,""));		
			
		}
	
		return Trim(ArrayToList(result, variables.NL));
	}
	
	public string function dumpArray(required array arrayToDump){
		var result = [];
		var i = 0;
		
		ArrayAppend(result, "Array: " & arraylen(arrayToDump) & " items");
		ArrayAppend(result, "--------------------");
		for (i=1; i <= arraylen(arrayToDump); i++ ){
			if (isSimpleValue(arrayToDump[i])){
				ArrayAppend(result, padStr(i,len(arraylen(arrayToDump))) & ". " & arrayToDump[i]);
			}
			else{
				ArrayAppend(result, padStr(i,len(arraylen(arrayToDump))) & ". " & dump(arrayToDump[i]));
			}
		}
	
		return Trim(ArrayToList(result, variables.NL));
	}
	
	public string function dumpStruct(required struct structToDump){
		var result = [];
		var i = 0;
		var keys = StructKeyArray(arguments.structToDump);
		var longest = lenOflongestInArray(keys);
		
		ArraySort(keys,"text", "asc"); 
		
		ArrayAppend(result, "Struct: " & arraylen(keys) & " items");
		ArrayAppend(result, "--------------------");
		for (i=1; i <= arraylen(keys); i++ ){
			if (isSimpleValue(structToDump[keys[i]])){
				ArrayAppend(result, padStr(keys[i],longest) & ": " & structToDump[keys[i]]);
			}
			else{
				ArrayAppend(result, padStr(keys[i],longest) & ": " & dump(structToDump[keys[i]]));
			}
		}
	
		return Trim(ArrayToList(result, variables.NL));
	}
	
	public string function padStr(required string str, required numeric len, string align="right"){
		var result = [];
		var i = 0;
		for (i=len(str); i<arguments.len; i++){
			ArrayAppend(result, " ");
		}
		if (FindNoCase("left", arguments.align)){
			ArrayPrepend(result, str);
		}
		else{
			ArrayAppend(result, str);
		}
		
		
		
		
		return ArrayToList(result, ""); 
	}
	
	public numeric function lenOflongestInArray(required array arrayToCount){
		var countArray = [];
		var i= 0;
		for(i=1;i<= ArrayLen(arguments.arrayToCount); i++){
			ArrayAppend(countArray, len(arguments.arrayToCount[i]));
		}
		ArraySort(countArray,"numeric","desc");
		
		return countArray[1];  
	}
	
	public struct function lenOflongestInQueryColumns(required query queryToCount){
		
		var i = 0;
		var j = 0;
		var columns = ListToArray(arguments.queryToCount.columnList);
		var result ={};
		
		for(j=1; j<= ArrayLen(columns); j++){
			var column = columns[j];
			var countArray = [];
			ArrayAppend(countArray, len(column));
			for(i=1;i<= arguments.queryToCount.recordCount; i++){
				ArrayAppend(countArray, len(arguments.queryToCount[column][i]));
			}
			ArraySort(countArray,"numeric","desc");
		
			result[columns[j]]=countArray[1]; ; 
		}
		
		return result; 
	}
    

}