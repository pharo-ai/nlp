Class {
	#name : #AIStemmer,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classVars : [
		'English'
	],
	#category : #'AI-NLP-Stemmer'
}

{ #category : #accessing }
AIStemmer >> cache [
	"Answer the cache of stemmed words."
	
	^cache isNil
		ifTrue: [cache := Dictionary new]
		ifFalse: [cache]
]

{ #category : #private }
AIStemmer >> purgeCache [
	"Clear the recievers cache of stemmed words."
	
	cache := nil
]

{ #category : #accessing }
AIStemmer >> stem: aString [
	"Answer the the morphological root of a word, ie removes its suffix."
	
	^self cache
		at: aString
		ifAbsentPut: [self performStemming: aString]
]
