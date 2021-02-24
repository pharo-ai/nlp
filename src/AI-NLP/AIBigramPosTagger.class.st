Class {
	#name : #AIBigramPosTagger,
	#superclass : #Object,
	#instVars : [
		'trainData',
		'trainTokens',
		'hiddenStates'
	],
	#category : #'AI-NLP-PoS'
}

{ #category : #accessing }
AIBigramPosTagger >> computeEmissionProbabilities [ 
	|countOfTags countOfWordGivenTags probabilityOfWordGivenTag|
	countOfTags := hiddenStates asBag.
	countOfWordGivenTags := trainData asBag.
	
	probabilityOfWordGivenTag := Dictionary new.
	
	countOfWordGivenTags do: [ :each | probabilityOfWordGivenTag at: each put: (countOfWordGivenTags occurrencesOf: each) / (countOfTags occurrencesOf: (each at: 2) ) ].
	
 	^probabilityOfWordGivenTag 
]

{ #category : #accessing }
AIBigramPosTagger >> computeTransitionProbabilities [
	|transitionProbabilities nHiddenStateCount historyHiddenStateCount|
	transitionProbabilities := Dictionary new.
	
	nHiddenStateCount := (self ngrams: 2 elements: hiddenStates padWith: '<s>' ) asBag.
	historyHiddenStateCount := (self ngrams: 1 elements: hiddenStates padWith: '<s>' ) asBag.
	
	nHiddenStateCount do: [ :each | transitionProbabilities at: each put: ((nHiddenStateCount occurrencesOf: each) / (historyHiddenStateCount occurrencesOf: each history)) ].
	
	^transitionProbabilities
]

{ #category : #accessing }
AIBigramPosTagger >> ngrams: value elements: aCollection padWith: padSymbol [
	| elements |
	elements := aCollection asOrderedCollection.
	
	(2 - 2) timesRepeat: [
		elements addFirst: padSymbol.
		elements addLast: padSymbol ].
	
	^ elements ngrams: value.
]

{ #category : #accessing }
AIBigramPosTagger >> trainOn: anArrayOfArrays [
	|hmm |
	trainData := anArrayOfArrays.
	trainTokens := anArrayOfArrays collect: [ :array | (array at: 1) asLowercase ].
	hiddenStates := anArrayOfArrays collect: [ :array | (array at: 2) ].
	
	hmm := AIHiddenMarkovModel new.
	hmm withTransitions: self computeTransitionProbabilities  andEmissions: self computeEmissionProbabilities andStates: hiddenStates asSet andObservations: trainTokens asSet.
	^hmm
	
]
