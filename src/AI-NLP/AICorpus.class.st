"
A corpus is an object which has documents (each document has its own terms). A document can be any object.
"
Class {
	#name : #AICorpus,
	#superclass : #Object,
	#instVars : [
		'documents'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #example }
AICorpus class >> deer90 [
	"self deer90"
	
	| data corpus |
	data := #(#(#c1 'Human machine interface for Lab ABC computer applications') #(#c2 'A survey of user opinion of computer system response time') #(#c3 'The EPS user interface management system') #(#c4 'System and human system engineering testing of EPS') #(#c5 'Relation of user-perceived response time to error measurement') #(#m1 'The generation of random, binary, unordered trees') #(#m2 'The intersection graph of paths in trees') #(#m3 'Graph minors IV: Widths of trees and well-quasi-ordering') #(#m4 'Graph minors: A survey')).

	corpus := AICorpus new.
	data do: [:each |
		corpus addDocument: each first with: (AITerms fromString: each last)].
	^ corpus
]

{ #category : #'instance creation' }
AICorpus class >> new [
	
	^self basicNew initialize
]

{ #category : #adding }
AICorpus >> addDocument: anObject [

	documents at: anObject ifAbsentPut: [ AITerms new ]
]

{ #category : #adding }
AICorpus >> addDocument: anObject with: terms [
		
	self addDocument: anObject.
	self atDocument: anObject add: terms
]

{ #category : #adding }
AICorpus >> addDocument: aString withContent: contentString [
	
	self
		addDocument: aString
		with: (AITerms new
				addString: contentString using: AICamelcaseScanner;
				yourself)
]

{ #category : #adding }
AICorpus >> addFile: aFilename [
	
	self
		addDocument: aFilename asString
		withContent: aFilename contentsOfEntireFile
]

{ #category : #adding }
AICorpus >> atDocument: anObject [
	
	^documents at: anObject
]

{ #category : #adding }
AICorpus >> atDocument: anObject add: terms [
	
	(documents at: anObject) addAll: terms
]

{ #category : #enumerating }
AICorpus >> documentTermCountDo: aBlock [
	
	documents
		keysAndValuesDo:
			[:document :terms | 
			terms
				withCountDo:
					[:term :count | aBlock value: document value: term value: count]]
]

{ #category : #accessing }
AICorpus >> documents [
	
	^documents keys
]

{ #category : #'initialize-release' }
AICorpus >> initialize [
	
	documents := Dictionary new
]

{ #category : #removing }
AICorpus >> removeStopwords [

	documents do: [:each | each removeStopwords]
]

{ #category : #removing }
AICorpus >> stemAll [
	
	documents do: [:each | each stemAll]
]

{ #category : #accessing }
AICorpus >> terms [
	
	| all |
	all := AITerms new.
	documents do: [:each | all addAll: each].
	^all
]
