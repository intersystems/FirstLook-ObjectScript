/// Person class for ObjectScript FirstLook<br>
Class FirstLook.Person Extends %Persistent
{

Property FirstName As %String [ Required ];

Property LastName As %String [ Required ];

/// Given an instance of a person, write person's name<br>
/// To call from Terminal:<br>
/// do person.WriteName()
Method WriteName()
{
	write "The name of this person is:"
	write !, ..FirstName
	write !, ..LastName
}

/// Query for all stored names<br>
/// Called from ClassMethod WriteAllNames()<br>
/// To call from Terminal:<br>
/// do ##class(%ResultSet).RunQuery("FirstLook.Person", "Select")
Query Select() As %SQLQuery [ SqlProc ]
{
	SELECT %ID, FirstName, LastName 
	FROM Person
	ORDER By LastName, FirstName
}

/// Run select query and write all names in result set<br>
/// To call from Terminal:<br>
/// do ##class(FirstLook.Person).WriteAllNames()
ClassMethod WriteAllNames()
{
	// Create a new %SQL.Statement object
	set stmt = ##class(%SQL.Statement).%New()
	// Prepare the class query to execute by passing in 
	// the ClassName and QueryName.  
	set status = stmt.%PrepareClassQuery("FirstLook.Person", "Select")

	// Handle any errors	
	if $$$ISERR(status) { 
		do $system.OBJ.DisplayError(status)
		quit  
	}
    
	// Execute the query
	set resultSet = stmt.%Execute()
	// Iterate over results
	while (resultSet.%Next()) {
		// Write person's first and last name
		write !, resultSet.%Get("FirstName"), " ", resultSet.%Get("LastName")
	}
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FirstName</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
</Data>
<DataLocation>^FirstLook.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^FirstLook.PersonD</IdLocation>
<IndexLocation>^FirstLook.PersonI</IndexLocation>
<StreamLocation>^FirstLook.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
