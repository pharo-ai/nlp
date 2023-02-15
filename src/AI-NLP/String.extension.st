Extension { #name : #String }

{ #category : #'*AI-NLP' }
String >> removeSpecialArtifacts [
	" Anwer a <String> with the receiver's copy without special artifacts defined in the default word tokenizer "

	| wordString |
	
	wordString := self removeSpecialArtifacts: AIWordTokenizer specialArtifacts.
	^ (wordString copyWithoutAll: ':.,()><-*?¿!"%$^&/§\#=[]{}') trimBoth
]

{ #category : #'*AI-NLP' }
String >> removeSpecialArtifacts: artifactsCollection [
	" Anwer a <String> with the receiver's copy without special artifacts defined in artifactsCollection "
	
	^ (self size <= 3 and: [ artifactsCollection includes: self ])
		ifTrue: [ String empty ]
		ifFalse: [ (self findBetweenSubstrings: artifactsCollection) joinUsing: ' ' ].
]

{ #category : #'*AI-NLP' }
String >> stemFrom: aPGPorterStemmer [ 
	" See comment in #stemOf: "

	^ aPGPorterStemmer performStemmingFromString: self.

]

{ #category : #'*AI-NLP' }
String >> tokenize [
	" Answer a <Collection> of <String> each one representing the receiver's tokens "

	^ AIWordTokenizer new 
		tokenize: self
]
