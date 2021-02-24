Class {
	#name : #AINgramSequenceableCollectionTest,
	#superclass : #TestCase,
	#instVars : [
		'collection'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #running }
AINgramSequenceableCollectionTest >> setUp [ 
	super setUp.
	collection := #(I do not like green eggs and ham).
]

{ #category : #running }
AINgramSequenceableCollectionTest >> testAsPGNgram [
	| ngram |
	ngram := collection asAINgram.
	self assert: ngram order equals: 8.
	self assert: ngram history equals: #(I do not like green eggs and) asAINgram.
	self assert: ngram last equals: 'ham'.
]

{ #category : #running }
AINgramSequenceableCollectionTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asAINgram .
		#(do not) asAINgram .
		#(not like) asAINgram .
		#(like green) asAINgram .
		#(green eggs) asAINgram .
		#(eggs and) asAINgram .
		#(and ham) asAINgram }.
	
	actual := collection bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testBigramsPadWith [
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
		
	actual := collection bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testBigramsWithDefaultPadding [
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
		
	actual := collection bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram }.
	
	actual := collection ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgramsPadWith [
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
		
	actual := collection ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgramsWithDefaultPadding [
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
		
	actual := collection ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asAINgram .
		#(do not like green eggs) asAINgram .
		#(not like green eggs and) asAINgram .
		#(like green eggs and ham) asAINgram }.
	
	actual := collection pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagramsPadWith [
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
		
	actual := collection pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagramsWithDefaultPadding [
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
		
	actual := collection pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asAINgram .
		#(do not like green) asAINgram .
		#(not like green eggs) asAINgram .
		#(like green eggs and) asAINgram .
		#(green eggs and ham) asAINgram }.
	
	actual := collection tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragramsPadWith [
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
		
	actual := collection tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragramsWithDefaultPadding [
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
		
	actual := collection tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asAINgram .
		#(do not like) asAINgram .
		#(not like green) asAINgram .
		#(like green eggs) asAINgram .
		#(green eggs and) asAINgram .
		#(eggs and ham) asAINgram }.
	
	actual := collection trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigramsPadWith [
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
		
	actual := collection trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigramsWithDefaultPadding [
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
		
	actual := collection trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigrams [
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
	
	actual := collection unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigramsPadWith [
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
	
	actual := collection unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigramsWithDefaultPadding [
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
	
	actual := collection unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]
