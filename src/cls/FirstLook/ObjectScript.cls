/// ObjectScript First Look
Class FirstLook.ObjectScript
{

/// Iterate over global ^testglobal<br>
/// To call from Terminal:<br>
/// do ##class(FirstLook.ObjectScript).Iterate()
ClassMethod Iterate()
{
	// Start by setting subscript to ""
	set subscript = ""
	// "Argumentless" for loop
	for {
		// Get the next subscript
		set subscript = $order(^testglobal(subscript))
		// When we get to the end, quit the for loop
		if (subscript = "") quit
		// Otherwise, write the subscript and the value
		// stored at ^testglobal(subscript)
		write !, "subscript=", subscript, ", value=", ^testglobal(subscript)
	}
}

}
