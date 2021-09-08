Extension { #name : #Association }

{ #category : #'*AI-NLP' }
Association >> removeSpecialArtifacts [
	" Assume the key contains a <String> representing a document. Answer an <Association> with the receiver's copy without special artifacts defined in a word tokenizer "

	^ self key removeSpecialArtifacts -> self value
]
