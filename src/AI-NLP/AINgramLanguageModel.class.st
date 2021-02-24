Class {
	#name : #AINgramLanguageModel,
	#superclass : #Object,
	#instVars : [
		'trainData',
		'historyCounts',
		'ngramCounts',
		'order'
	],
	#category : #'AI-NLP-NGram'
}

{ #category : #accessing }
AINgramLanguageModel >> buildVocab [
	^ trainData asBag.
]

{ #category : #accessing }
AINgramLanguageModel >> countOfHistory: anNgramHistory [
	^ historyCounts occurrencesOf: anNgramHistory
]

{ #category : #accessing }
AINgramLanguageModel >> countOfNgram: anNgram [
	^ ngramCounts occurrencesOf: anNgram
]

{ #category : #accessing }
AINgramLanguageModel >> countOfUniqueNgramsEndingWith: aWord [
	^ (ngramCounts asSet select: [ :ngram | ngram last = aWord ]) size
]

{ #category : #accessing }
AINgramLanguageModel >> countOfUniqueNgramsWithHistory: ngram [
	^ (ngramCounts asSet
		select: [ :eachNgram | eachNgram history = ngram ]) size.
]

{ #category : #accessing }
AINgramLanguageModel >> historyCounts [
	^historyCounts
]

{ #category : #initialization }
AINgramLanguageModel >> initialize [ 
	super initialize.
	ngramCounts := Bag new.
	historyCounts := Bag new.
]

{ #category : #accessing }
AINgramLanguageModel >> ngramCounts [
	^ngramCounts
]

{ #category : #accessing }
AINgramLanguageModel >> order [ 
	^order
]

{ #category : #accessing }
AINgramLanguageModel >> predictNextWord: anNgramHistory [
	| ngramsWithHistory topOne |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = anNgramHistory  ].
	topOne := ngramsWithHistory sortedCounts first value.
	^ topOne last
]

{ #category : #accessing }
AINgramLanguageModel >> predictNextWord: history top: aNumber [
	| ngramsWithHistory lo topOnes |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	ngramsWithHistory := ngramsWithHistory sortedCounts.
	lo := (ngramsWithHistory size - aNumber + 1) max: 1.
	topOnes := (ngramsWithHistory copyFrom: lo to: ngramsWithHistory size) collect: #value.
	^ topOnes collect: #last
]

{ #category : #accessing }
AINgramLanguageModel >> probabilityOfNgram: ngram [
	"Probability of n-gram is a conditional probability of its last word w given the history h (n-gram of order n-1): P(w|h)"
	|histCount ngramCount|
	ngramCount := self countOfNgram: ngram.
	histCount := self countOfHistory: ngram history.
	
	(ngramCount = 0)
		ifTrue: [ ^ 0 ].
	
	^ (ngramCount / histCount) asFloat.
]

{ #category : #accessing }
AINgramLanguageModel >> probabilityOfText: anArrayOfWords [
	| ngrams |
	ngrams := (anArrayOfWords collect: [ :token | token asLowercase ]) ngrams: order.
	^(ngrams collect: [ :ngram | self probabilityOfNgram: ngram.])
		inject: 1 into: [ :prod :each | prod * each ].

]

{ #category : #accessing }
AINgramLanguageModel >> topNgrams: order [
	| ngramsCollection |
	ngramsCollection := (trainData ngrams: order) asBag sortedCounts.
	^ ngramsCollection
]

{ #category : #accessing }
AINgramLanguageModel >> topNgrams: order k: count [
	| ngramsCollection |
	ngramsCollection := (trainData ngrams: order) asBag sortedCounts.
	^ (1 to: count) collect: [ :index | ngramsCollection at: index ] 
]

{ #category : #accessing }
AINgramLanguageModel >> totalNgramCountInText [
	^ ngramCounts size
]

{ #category : #accessing }
AINgramLanguageModel >> trainData [
	^trainData 
]

{ #category : #accessing }
AINgramLanguageModel >> trainOn: anArrayOfTokens order: value [
	| trainNgrams |
	
	order := value.
	trainData := anArrayOfTokens collect: [ :token | token asLowercase ].
	trainNgrams := trainData ngramsWithDefaultPadding: value.
	
	"trainNgrams do: [ :each | ngramCounts add: each ]."
	ngramCounts := trainNgrams asBag.
	
	ngramCounts doWithOccurrences: [ :ngram :count |
		historyCounts add: ngram history withOccurrences: count ].
	
	^trainNgrams 
]
