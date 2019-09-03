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
	// Create a new ResultSet object
	set resultSet = ##class(%ResultSet).%New()
	// Specify the class query to execute by setting 
	// the ClassName and QueryName properties.  
	set resultSet.ClassName = "FirstLook.Person"
	set resultSet.QueryName = "Select"
	// Execute the query
	set status = resultSet.%Execute()
	// If status = $$$OK, query is successful
	if (status = $$$OK) {
		// Iterate over results
		while (resultSet.%Next()) {
			// Write person's first and last name
			write !, resultSet.FirstName, " ", resultSet.LastName
		}
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
