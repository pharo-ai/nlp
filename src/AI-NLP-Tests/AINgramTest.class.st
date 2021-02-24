Class {
	#name : #AINgramTest,
	#superclass : #TestCase,
	#category : #'AI-NLP-Tests'
}

{ #category : #tests }
AINgramTest >> testAsArray [
	| ngram expected actual |
	ngram := #(1 2 3) asAINgram.
	expected := #(1 2 3).
	actual := ngram asArray.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testEquality [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum dolor) asAINgram.
	secondNgram :=  #(lorem ipsum dolor) asAINgram.
	
	self assert: firstNgram equals: secondNgram.
	self assert: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testHistory [
	| ngram |
	ngram := #(lorem ipsum dolor) asAINgram. 
	self assert: ngram history equals: #(lorem ipsum) asAINgram.
]

{ #category : #tests }
AINgramTest >> testInequalitySize [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum) asAINgram.
	secondNgram :=  #(lorem ipsum dolor) asAINgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testInequalityValues [
	| firstNgram secondNgram |
	firstNgram := #(lorem dolor dolor) asAINgram.
	secondNgram :=  #(lorem ipsum dolor) asAINgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testLast [
	| ngram |
	ngram := #(lorem ipsum dolor) asAINgram. 
	self assert: ngram last equals: 'dolor'.
]

{ #category : #tests }
AINgramTest >> testNew [
	self should: [ AINgram new ] raise: Error.
]

{ #category : #tests }
AINgramTest >> testOrder [
	| ngram |
	ngram := #(lorem ipsum dolor sit) asAINgram. 
	self assert: ngram order equals: 4.
]

{ #category : #tests }
AINgramTest >> testPrintOn [
	| ngram stream expected actual |
	
	ngram := #(hello world) asAINgram.
	stream := String new writeStream.
	ngram printOn: stream.
	
	expected := 'PGn-gram(hello world)'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testWithElements [
	| ngram |
	ngram := AINgram withElements: #(1 2 3).
	self assert: ngram order equals: 3.
]

{ #category : #tests }
AINgramTest >> testWithElementsEmptyArray [
	| ngram |
	ngram := AINgram withElements: #().
	self assert: ngram order equals: 0.
]

{ #category : #tests }
AINgramTest >> testWithHistoryLast [
	| expected actual |
	expected := #(1 2 3) asAINgram.
	actual := AINgram withHistory: #(1 2) asAINgram last: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testZerogram [
	| ngram |
	ngram := AINgram zerogram. 
	self assert: ngram order equals: 0.
	self assert: ngram history isEmpty.
	self assert: ngram last isNil.
]
