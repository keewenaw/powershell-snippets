# ^ - beginning of line
# $ - end of line
# [^] - does not contain
# [] - contains
# . - single character
# \w - word
#	\p{} = Ll (letter lowercase), Lu (letter uppercase), Nd (number, decimal), Pc (punctuation connector)
# 	\n (newline), \t (tab), \s (space), \S (non whitespace)
#	\d (decimal), \D (non digit)
# {n,} - match n+ occurences
# * - zero or more occurences
# + - one or more occurences
# {x|y} - match x or y
# ? - optional (0 or 1)

Function regex-hasWhiteSpace {
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)

	echo ""	
	$string -match '^.+\s+.+$'
	echo ""
}

Function regex-hasSymbols {
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string -match '^.+[^0-9a-zA-Z].+$'
	echo ""
}

Function regex-isEmpty{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string -match '^$'
	echo ""
}

Function regex-isWhiteSpace{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string -match '^\s+$'
	echo ""
}

Function regex-isValidEmail{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string=$string.trim()
	$string -match '^\w+@\w+\.\w{3}$'
	echo ""
}

Function regex-isValidIPAddress{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string=$string.trim()
	$string -match '^([0-9]\.|[1-9][0-9]\.|[1-2][0-5][0-5]\.){3}([0-9]|[1-9][0-9]|[1-2][0-5][0-5])$'
	echo ""
}

Function regex-isValidID{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	echo ""
	$string=$string.trim()
	$string -match '^([a-zA-z]\d{6}|[cC]\d{5}[cC]|[eE]\d{5}[eE])$'
	echo ""
}

Function regex-removeWhiteSpace{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	$string -replace '\s+',''
}

Function regex-removeSymbols{
	Param(
	[Parameter(Mandatory=$true)]
	$string
	)
	
	$string -replace '[^0-9a-zA-Z ]',''
}
