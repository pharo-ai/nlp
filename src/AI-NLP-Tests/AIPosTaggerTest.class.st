Class {
	#name : #AIPosTaggerTest,
	#superclass : #TestCase,
	#instVars : [
		'tagger'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #running }
AIPosTaggerTest >> setUp [
	|trainData|
	trainData := #( #('my' 'pron') #('head' 'noun') #('is' 'verb') #('blowing' 'verb') #('the' 'det') #('my' 'pron') #('head' 'noun') #('is' 'noun') #('is' 'noun')). 
	tagger := AIPosTagger new.
	tagger trainOn: trainData order: 3.
]

{ #category : #tests }
AIPosTaggerTest >> testComputeTransitionProbabilities [
	| result|
	result := tagger computeTransitionProbabilities.
]
