Class {
	#name : #AITermScanner,
	#superclass : #Object,
	#instVars : [
		'stream',
		'buffer',
		'term'
	],
	#classVars : [
		'Void'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #'instance creation' }
AITermScanner class >> new [
	
	^self basicNew initialize
]

{ #category : #running }
AITermScanner class >> scan: input [

	| scanner |
	scanner := self new onStream: input readStream.
	^ scanner allTerms.
]

{ #category : #running }
AITermScanner >> allTerms [

	| bag |	
	bag := AITerms new.
	[ self atEnd ] whileFalse: [ bag add: self next ].
	^ bag
]

{ #category : #scanning }
AITermScanner >> atEnd [

	term == Void ifTrue: [term := self privateNext].	
	^term isNil
]

{ #category : #'initialize-release' }
AITermScanner >> initialize [
	
	buffer := String new writeStream
]

{ #category : #scanning }
AITermScanner >> next [
	
	^term == Void
		ifTrue: [self privateNext]
		ifFalse:
			[ |result|
			result := term.
			term := Void.
			result]
]

{ #category : #running }
AITermScanner >> onFile: filename [
	
	self onStream: filename asFileReference readStream
]

{ #category : #running }
AITermScanner >> onStream: input [
	
	stream := input.
	term := Void
]

{ #category : #running }
AITermScanner >> onString: text [
	
	self onStream: text readStream
]

{ #category : #private }
AITermScanner >> privateNext [

	| next |	
	buffer reset.

	[	[(next := stream informationRetrievalNext) isLetter ] whileFalse.
		[buffer nextPut: next asLowercase.
		 (next := stream informationRetrievalNext) isLetter] whileTrue.
		[(next := stream informationRetrievalNext) isLetter ] whileFalse.
		stream skip: -1.
	] on: Stream endOfStreamSignal do: [:ex | "-- do nothing" ].
	
	^buffer contents isEmpty
		ifTrue: [nil]
		ifFalse: [buffer contents]
]

{ #category : #accessing }
AITermScanner >> stream [
	
	^stream
]
