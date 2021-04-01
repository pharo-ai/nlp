Class {
	#name : #AIInverseDocumentFrequency,
	#superclass : #AIGlobalWeighting,
	#category : #'AI-NLP-TFIDF'
}

{ #category : #accessing }
AIInverseDocumentFrequency >> abbreviation [
	
	^'idf'
]

{ #category : #weighting }
AIInverseDocumentFrequency >> forTerm: aVector [
	"^1 + ((aVector size / (self documentFrequency: aVector)) log: 2)"
	
	^aVector size / (self documentFrequency: aVector) log: 2
]
