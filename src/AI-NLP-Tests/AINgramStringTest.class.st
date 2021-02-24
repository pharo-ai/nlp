Class {
	#name : #AINgramStringTest,
	#superclass : #TestCase,
	#instVars : [
		'text'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #running }
AINgramStringTest >> setUp [ 	
	super setUp.
	text := 'I do not like green eggs and ham'.
]

{ #category : #tests }
AINgramStringTest >> testAsPGNgram [
	| str expected actual |
	str := 'hello'.
	expected := #(hello) asAINgram.
	actual := str asAINgram.
	self assert: actual equals: expected.
	
]

{ #category : #tests }
AINgramStringTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asAINgram .
		#(do not) asAINgram .
		#(not like) asAINgram .
		#(like green) asAINgram .
		#(green eggs) asAINgram .
		#(eggs and) asAINgram .
		#(and ham) asAINgram }.
	
	actual := text bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testBigramsPadWith [
	| expected actual |
	
	expected := {
		#('##' I) asAINgram .
		#(I do) asAINgram .
		#(do not) asAINgram .
		#(not like) asAINgram .
		#(like green) asAINgram .
		#(green eggs) asAINgram .
		#(eggs and) asAINgram .
		#(and ham) asAINgram .
		#(ham '##') asAINgram }.
		
	actual := text bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testBigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' I) asAINgram .
		#(I do) asAINgram .
		#(do not) asAINgram .
		#(not like) asAINgram .
		#(like green) asAINgram .
		#(green eggs) asAINgram .
		#(eggs and) asAINgram .
		#(and ham) asAINgram .
		#(ham '<s>') asAINgram }.
		
	actual := text bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram }.
	
	actual := text ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' I) asAINgram .
		#('##' I do) asAINgram .
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram .
		#(and ham '##') asAINgram .
		#(ham '##' '##') asAINgram }.
		
	actual := text ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' I) asAINgram .
		#('<s>' I do) asAINgram .
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram .
		#(and ham '<s>') asAINgram .
		#(ham '<s>' '<s>') asAINgram }.
		
	actual := text ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asAINgram .
		#(do not like green eggs) asAINgram .
		#(not like green eggs and) asAINgram .
		#(like green eggs and ham) asAINgram }.
	
	actual := text pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' '##' '##' I) asAINgram .
		#('##' '##' '##' I do) asAINgram .
		#('##' '##' I do not) asAINgram .
		#('##' I do not like) asAINgram .
		#(I do not like green) asAINgram .
		#(do not like green eggs) asAINgram .
		#(not like green eggs and) asAINgram .
		#(like green eggs and ham) asAINgram .
		#(green eggs and ham '##') asAINgram .
		#(eggs and ham '##' '##') asAINgram .
		#(and ham '##' '##' '##') asAINgram .
		#(ham '##' '##' '##' '##') asAINgram }.
		
	actual := text pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' '<s>' '<s>' I) asAINgram .
		#('<s>' '<s>' '<s>' I do) asAINgram .
		#('<s>' '<s>' I do not) asAINgram .
		#('<s>' I do not like) asAINgram .
		#(I do not like green) asAINgram .
		#(do not like green eggs) asAINgram .
		#(not like green eggs and) asAINgram .
		#(like green eggs and ham) asAINgram .
		#(green eggs and ham '<s>') asAINgram .
		#(eggs and ham '<s>' '<s>') asAINgram .
		#(and ham '<s>' '<s>' '<s>') asAINgram .
		#(ham '<s>' '<s>' '<s>' '<s>') asAINgram }.
		
	actual := text pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asAINgram .
		#(do not like green) asAINgram .
		#(not like green eggs) asAINgram .
		#(like green eggs and) asAINgram .
		#(green eggs and ham) asAINgram }.
	
	actual := text tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' '##' I) asAINgram .
		#('##' '##' I do) asAINgram .
		#('##' I do not) asAINgram .
		#(I do not like) asAINgram .
		#(do not like green) asAINgram .
		#(not like green eggs) asAINgram .
		#(like green eggs and) asAINgram .
		#(green eggs and ham) asAINgram .
		#(eggs and ham '##') asAINgram .
		#(and ham '##' '##') asAINgram .
		#(ham '##' '##' '##') asAINgram }.
		
	actual := text tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' '<s>' I) asAINgram .
		#('<s>' '<s>' I do) asAINgram .
		#('<s>' I do not) asAINgram .
		#(I do not like) asAINgram .
		#(do not like green) asAINgram .
		#(not like green eggs) asAINgram .
		#(like green eggs and) asAINgram .
		#(green eggs and ham) asAINgram .
		#(eggs and ham '<s>') asAINgram .
		#(and ham '<s>' '<s>') asAINgram .
		#(ham '<s>' '<s>' '<s>') asAINgram }.
		
	actual := text tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram }.
	
	actual := text trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' I) asAINgram .
		#('##' I do) asAINgram .
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram .
		#(and ham '##') asAINgram .
		#(ham '##' '##') asAINgram }.
		
	actual := text trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' I) asAINgram .
		#('<s>' I do) asAINgram .
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram .
		#(and ham '<s>') asAINgram .
		#(ham '<s>' '<s>') asAINgram }.
		
	actual := text trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigrams [
	| expected actual |
	
	expected := {
		#(I) asAINgram .
		#(do) asAINgram .
		#(not) asAINgram .
		#(like) asAINgram .
		#(green) asAINgram .
		#(eggs) asAINgram .
		#(and) asAINgram .
		#(ham) asAINgram }.
	
	actual := text unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigramsPadWith [
	| expected actual |
	
	expected := {
		#(I) asAINgram .
		#(do) asAINgram .
		#(not) asAINgram .
		#(like) asAINgram .
		#(green) asAINgram .
		#(eggs) asAINgram .
		#(and) asAINgram .
		#(ham) asAINgram }.
	
	actual := text unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#(I) asAINgram .
		#(do) asAINgram .
		#(not) asAINgram .
		#(like) asAINgram .
		#(green) asAINgram .
		#(eggs) asAINgram .
		#(and) asAINgram .
		#(ham) asAINgram }.
	
	actual := text unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]
