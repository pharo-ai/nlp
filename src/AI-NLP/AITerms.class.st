"
Terms can be added from Strings 
"
Class {
	#name : #AITerms,
	#superclass : #Bag,
	#instVars : [
		'size',
		'stopwords'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #accesing }
AITerms class >> fromCollection: aCollection [

	| terms |
	terms := AITerms new.
	aCollection do: [ :string | terms addString: string using: AICamelcaseScanner ].
	^ terms
]

{ #category : #'instance creation' }
AITerms class >> fromFile: aFile [
	
	^ AITermScanner new
		onFile: aFile;
		allTerms
]

{ #category : #'instance creation' }
AITerms class >> fromString: aString [

	| scanner |

	scanner := AITermScanner new.
	scanner onString: aString.	
	^ scanner allTerms.			
		
]

{ #category : #examples }
AITerms class >> sample [
	
	^self fromString:
			'I think that I shall never see
		a graph more lovely than a tree.
		A tree whose crucial property
		is loop-free connectivity.
		A tree that must be sure to span
		so packet can reach every LAN.
		First, the root must be selected.
		By ID, it is elected.
		Least-cost paths from root are traced.
		In the tree, these paths are placed.
		A mesh is made by folks like me,
		then bridges find a spanning tree.'
]

{ #category : #adding }
AITerms >> addString: aString [
	" Add a token delimited <String> into the receiver's using a default scanner for terms "
	
	^ self addString: aString using: AITermScanner
]

{ #category : #adding }
AITerms >> addString: string using: scannerClass [
	
	| scanner |
	scanner := scannerClass new.
	scanner onString: string.
	[scanner atEnd] whileFalse: [self add: scanner next]
]

{ #category : #adding }
AITerms >> addTerms: termsBag [
	" Add <AITerms> in termsBag to the receiver "

	termsBag withCountDo: [ :each :count | self add: each withOccurrences: count ]
]

{ #category : #accessing }
AITerms >> distinctSize [
	
	^contents associations size
]

{ #category : #accessing }
AITerms >> fastSize [
	
	^size ifNil: [size := super size]
]

{ #category : #converting }
AITerms >> normalized [
	
	| newTerms sum length |
	newTerms := AITerms new: contents size.
	sum := 0.
	contents do: [:count | sum := sum + (count * count)].
	length := sum sqrt.
	self withCountDo: [:each :count | 
		newTerms add: each withOccurrences: count asFloat / length].
	^newTerms
]

{ #category : #removing }
AITerms >> prune [
	
	self removeStopwords.
	self stemAll.
	self removeHapaxes.
]

{ #category : #removing }
AITerms >> removeHapaxes [
	
	self removeRareTerms: 1
]

{ #category : #removing }
AITerms >> removeRareTerms: occurrence [
	
	| newTerms |
	newTerms := AITerms new: contents capacity.
	self withCountDo: [:term :count | 
		count > occurrence
			ifTrue: [newTerms add: (AIStemmer stem: term) withOccurrences: count]].
	self become: newTerms
]

{ #category : #removing }
AITerms >> removeStopwords [
	" Answer a <> without stopwords defined in the receiver's stopwords collection "

	^ self removeStopwords: self stopwords
]

{ #category : #removing }
AITerms >> removeStopwords: stopwords [

	stopwords do: [:each | 
		contents removeKey: each ifAbsent: nil]
]

{ #category : #removing }
AITerms >> stemAll [
	
	| newTerms |
	newTerms := AITerms new: contents capacity.
	self
		withCountDo:
			[:term :count | 
			newTerms
				add: (AIStemmer new stem: term) 
				withOccurrences: count].
	self become: newTerms
]

{ #category : #accessing }
AITerms >> stopwords [
	" Answer a <Collection> containing stopwords for the receiver's use "

	^ stopwords
		ifNil: [ stopwords := AIStopwords forEnglish ]
]

{ #category : #accessing }
AITerms >> stopwords: anObject [

	stopwords := anObject
]

{ #category : #enumerating }
AITerms >> termsDo: aBlock [
	
	contents associationsDo: [:each | aBlock value: each key]	"!!! value -> count !!!"
]

{ #category : #converting }
AITerms >> top: topTenSize [
	
	^(self sortedCounts first: topTenSize) collect: #key
]

{ #category : #converting }
AITerms >> topTen [
	
	^(self sortedCounts first: 10) collect: #value
]

{ #category : #accessing }
AITerms >> useStopwordsForEnglish [
	" Set the receiver to use stopwords for english language "

	self stopwords: AIStopwords forEnglish
]

{ #category : #accessing }
AITerms >> useStopwordsForFrench [
	" Set the receiver to use stopwords for french language "

	self stopwords: AIStopwords forFrench
]

{ #category : #accessing }
AITerms >> useStopwordsForSpanish [
	" Set the receiver to use stopwords for spanish language "

	self stopwords: AIStopwords forSpanish
]

{ #category : #enumerating }
AITerms >> withCountDo: aBlock [
	
	contents
		associationsDo:
			[:each | 
			aBlock
				value: each key
				value: each value]
]
