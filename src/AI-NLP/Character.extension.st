Extension { #name : #Character }

{ #category : #'*AI-NLP' }
Character >> stemFrom: aPGPorterStemmer [ 
	" See comment in #stemOf: "

	^ aPGPorterStemmer performStemmingFromCharacter: self.
]
