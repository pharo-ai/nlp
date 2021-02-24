"
An AINLTKPosTaggerTest is a test class for testing the behavior of AINLTKPosTagger
"
Class {
	#name : #AINLTKPosTaggerTest,
	#superclass : #TestCase,
	#instVars : [
		'nltkPosTagger'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #accessing }
AINLTKPosTaggerTest >> nltkPosTagger [
	^ nltkPosTagger
]

{ #category : #accessing }
AINLTKPosTaggerTest >> nltkPosTagger: anObject [
	nltkPosTagger := anObject
]

{ #category : #running }
AINLTKPosTaggerTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	nltkPosTagger := AINLTKPosTagger new.
]

{ #category : #test }
AINLTKPosTaggerTest >> testBuildPythonScript [

	| expected obtained |
	
	expected := 'import nltk
tokens = nltk.word_tokenize("Ground Control to Major Tom")
postags = nltk.pos_tag(tokens)
'.
	obtained := self nltkPosTagger buildPythonScript: 'Ground Control to Major Tom'.
	self assert: expected equals: obtained.
]
