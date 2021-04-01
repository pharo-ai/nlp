Extension { #name : #DataFrameCsvReader }

{ #category : #'*AI-NLP' }
DataFrameCsvReader >> readFromString: aString separator: aCharacter [ 
	"Read data frame from a CSV file"
	| reader df |

	reader := NeoCSVReader on: aString readStream.
	reader separator: aCharacter.
	self readRowsWith: reader.
	
	reader close.
	
	df := DataFrame withRows: rows.
	self includeRowNames ifTrue: [ df rowNames: rowNames ].
	shouldInferTypes ifTrue: [ DataFrameTypeDetector new detectTypesAndConvert: df ].

	^ df
]
