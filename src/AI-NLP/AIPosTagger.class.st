Class {
	#name : #AIPosTagger,
	#superclass : #Object,
	#instVars : [
		'trainData',
		'order',
		'hiddenStates',
		'trainTokens'
	],
	#category : #'AI-NLP-PoS'
}

{ #category : #accessing }
AIPosTagger >> computeEmissionProbabilities [
	|countOfTag countOfWordGivenTag probabilityOfWordGivenTag|
	
	countOfTag := Bag withAll: hiddenStates .
	countOfWordGivenTag := 0.
	probabilityOfWordGivenTag := 0.
]

{ #category : #accessing }
AIPosTagger >> computeTransitionProbabilities [
	|transitionProbabilities nHiddenStateCount historyHiddenStateCount|
	transitionProbabilities := Dictionary new.
	
	nHiddenStateCount := (self ngrams: order elements: hiddenStates padWith: '<s>' ) asBag.
	historyHiddenStateCount := (self ngrams: order-1 elements: hiddenStates padWith: '<s>' ) asBag.
	
	nHiddenStateCount do: [ :each | transitionProbabilities at: each put: ((nHiddenStateCount occurrencesOf: each) / (historyHiddenStateCount occurrencesOf: each history)) ].
	
	^transitionProbabilities
]

{ #category : #accessing }
AIPosTagger >> ngrams: value elements: aCollection padWith: padSymbol [
	| elements |
	elements := aCollection asOrderedCollection.
	
	(order - 2) timesRepeat: [
		elements addFirst: padSymbol.
		elements addLast: padSymbol ].
	
	^ elements ngrams: value.
]

{ #category : #accessing }
AIPosTagger >> trainOn: anArrayOfArrays order: value [

	order := value.
	trainData := anArrayOfArrays.
	trainTokens := anArrayOfArrays collect: [ :array | (array at: 1) asLowercase ].
	hiddenStates := anArrayOfArrays collect: [ :array | (array at: 2) ].
]
