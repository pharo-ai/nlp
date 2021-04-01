Extension { #name : #DataFrame }

{ #category : #'*AI-NLP' }
DataFrame class >> readFromString: aString [ 
	| reader |

	reader := DataFrameCsvReader new.
	^ self readFromString: aString using: reader.
]

{ #category : #'*AI-NLP' }
DataFrame class >> readFromString: aString  separator: aCharacter [
	| reader |

	reader := DataFrameCsvReader new.
	^ self readFromString: aString using: reader separator: aCharacter.
]

{ #category : #'*AI-NLP' }
DataFrame class >> readFromString: aLocation using: aDataFrameReader [
	"Read data frame from a given location using a given DataFrameReader. Location can be a file reference, a database connection, or something else (depending on the implementation of the reader)"

	^ aDataFrameReader readFromString: aLocation
]

{ #category : #'*AI-NLP' }
DataFrame class >> readFromString: aString using: aDataFrameCsvReader separator: aCharacter [ 

	^ aDataFrameCsvReader readFromString: aString separator: aCharacter 
]
