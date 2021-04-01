Class {
	#name : #AITermFrequencyInverseDocumentFrequency,
	#superclass : #Object,
	#instVars : [
		'perWordDocumentCount',
		'numberOfDocuments'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #internal }
AITermFrequencyInverseDocumentFrequency >> inverseDocumentFrequencyOf: aWord [
	^ self log: (self numberOfDocuments / (self numberOfDocumentsThatContainWord: aWord)).
]

{ #category : #hooks }
AITermFrequencyInverseDocumentFrequency >> log: aNumber [
	"Natural logarithm used to compute IDF. Can be overriden by subclasses"
	^ aNumber ln
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> numberOfDocuments [
	^ numberOfDocuments 
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> numberOfDocumentsThatContainWord: aWord [
	^ perWordDocumentCount occurrencesOf: aWord
	
]

{ #category : #internal }
AITermFrequencyInverseDocumentFrequency >> scoreOf: aWord in: aDocument [
	| tf idf |
	tf := self termFrequencyOf: aWord in: aDocument.
	idf := self inverseDocumentFrequencyOf: aWord.
	^ tf * idf
]

{ #category : #internal }
AITermFrequencyInverseDocumentFrequency >> termFrequencyOf: aWord in: aDocument [
	^ aDocument occurrencesOf: aWord
]

{ #category : #internal }
AITermFrequencyInverseDocumentFrequency >> trainOn: aCollectionOfDocuments [
	numberOfDocuments := aCollectionOfDocuments size.
	perWordDocumentCount := (aCollectionOfDocuments flatCollect: [ :document | document asSet ]) asBag.
]

{ #category : #internal }
AITermFrequencyInverseDocumentFrequency >> vectorFor: aDocument [
	^ self vocabulary collect: [ :word | self scoreOf: word in: aDocument ].
]

{ #category : #accessing }
AITermFrequencyInverseDocumentFrequency >> vocabulary [
	^ perWordDocumentCount asSet sorted
]
