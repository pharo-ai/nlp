Extension { #name : #AIMatrix }

{ #category : #'*AI-NLP' }
AIMatrix >> asDataFrame [

	^ DataFrame 
		readFromString: self asDenseString
		separator: Character space
]
