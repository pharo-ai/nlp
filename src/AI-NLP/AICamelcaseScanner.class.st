Class {
	#name : #AICamelcaseScanner,
	#superclass : #AITermScanner,
	#instVars : [
		'next'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #example }
AICamelcaseScanner class >> bible [

	^self new
		onFile: 'bible10.txt';
		allTerms
]

{ #category : #'initialize-release' }
AICamelcaseScanner >> onStream: input [

	super onStream: input.
	next := Character space
]

{ #category : #private }
AICamelcaseScanner >> privateNext [

	next isNil ifTrue: [^nil].
	buffer reset.
	[self xWhitespace.
	 next isLowercase
		ifTrue: [self xLowercaseWord]
		ifFalse: [self xCapitalizedWord]
	] on: Stream endOfStreamSignal do: [:ex | next := nil].

	^buffer contents isEmpty
		ifTrue: [nil]
		ifFalse: [buffer contents]
]

{ #category : #private }
AICamelcaseScanner >> xCapitalizedWord [

	buffer nextPut: next.
	next := stream informationRetrievalNext.
	next isLetter
		ifTrue: [ next isLowercase
				ifTrue: [	buffer collection at: 1put: buffer collection first asLowercase.
						self xLowercaseWord ]
				ifFalse: [self xUppercaseWord]
		]
]

{ #category : #private }
AICamelcaseScanner >> xLowercaseWord [

	[buffer nextPut: next.
	 next := stream informationRetrievalNext.
	 next isLowercase] whileTrue
]

{ #category : #private }
AICamelcaseScanner >> xUppercaseWord [

	[	|peek|
		peek := stream peek.
		next isLetter and: [peek == nil or: [peek isLowercase not]]
	] whileTrue: [
		buffer nextPut: next.
		 next := stream informationRetrievalNext ]
]

{ #category : #private }
AICamelcaseScanner >> xWhitespace [
	
	| previous |
	next isLetter
		ifFalse:
			[[previous := next.
			next := stream informationRetrievalNext.
			($0 == next and: [previous isSeparator]) ifTrue: [self xZeroWord].
			next isLetter] whileFalse]
]

{ #category : #private }
AICamelcaseScanner >> xZeroWord [
	
	[next isAlphaNumeric] whileTrue: [next := stream informationRetrievalNext]
]
