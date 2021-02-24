Extension { #name : #SequenceableCollection }

{ #category : #'*AI-NLP' }
SequenceableCollection >> asAINgram [
	^ AINgram withElements: self
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> bigrams [ 
	^ self ngrams: 2
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> bigramsPadWith: padSymbol [
	^ self ngrams: 2 padWith: padSymbol
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> bigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 2
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> defaultNgramPadding [
	^ '<s>'
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> ngrams: order [
	^ (1 to: self size - order + 1) collect: [ :i |
		(self copyFrom: i to: i + order - 1) asAINgram ]
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> ngrams: order padWith: padSymbol [
	| elements |
	elements := self asOrderedCollection.
	
	(order - 1) timesRepeat: [
		elements addFirst: padSymbol.
		elements addLast: padSymbol ].
	
	^ elements ngrams: order.
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> ngramsWithDefaultPadding: order [
	^ self ngrams: order padWith: self defaultNgramPadding.
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> pentagrams [ 
	^ self ngrams: 5
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> pentagramsPadWith: padSymbol [
	^ self ngrams: 5 padWith: padSymbol
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> pentagramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 5
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> stemFrom: aPGPorterStemmer [ 
	" See comment in #stemOf: "

	^ aPGPorterStemmer performStemmingFromSequenceableCollection: self.

]

{ #category : #'*AI-NLP' }
SequenceableCollection >> stemUsingPorter [
	" Answer a <Collection> of stemmed terms using the Porter algorithm "

	^ self collect: [ : obj | AIPorterStemmer stemOf: obj ]
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> tetragrams [ 
	^ self ngrams: 4
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> tetragramsPadWith: padSymbol [
	^ self ngrams: 4 padWith: padSymbol
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> tetragramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 4
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> tokenizeWithoutStopwords [
	" Answer a <Collection> of <String> each one representing the receiver's tokens without stopwords "

	^ self collectDisplayingProgress: #tokenizeWithoutStopwords.

]

{ #category : #'*AI-NLP' }
SequenceableCollection >> trigrams [ 
	^ self ngrams: 3
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> trigramsPadWith: padSymbol [
	^ self ngrams: 3 padWith: padSymbol
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> trigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 3
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> unigrams [ 
	^ self ngrams: 1
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> unigramsPadWith: padSymbol [
	^ self ngrams: 1 padWith: padSymbol
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> unigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 1
]
