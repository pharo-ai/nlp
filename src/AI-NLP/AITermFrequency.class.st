Class {
	#name : #AITermFrequency,
	#superclass : #AILocalWeighting,
	#category : #'AI-NLP-TFIDF'
}

{ #category : #accessing }
AITermFrequency >> abbreviation [
	
	^'tf'
]

{ #category : #weighting }
AITermFrequency >> forValue: value [
	
	^value
]
