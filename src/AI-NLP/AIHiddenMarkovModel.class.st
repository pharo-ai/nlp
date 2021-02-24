Class {
	#name : #AIHiddenMarkovModel,
	#superclass : #Object,
	#instVars : [
		'emissionProbabilities',
		'transitionProbabilities',
		'states',
		'observations'
	],
	#category : #'AI-NLP-PoS'
}

{ #category : #accessing }
AIHiddenMarkovModel >> withTransitions: transitionProbs andEmissions: emissionProbs andStates: possibleStates andObservations: possibleObservations [
	transitionProbabilities := transitionProbs.
	emissionProbabilities := emissionProbs.
	states := possibleStates.
	observations := possibleObservations.
]
