Class {
	#name : #AINgramLanguageModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #running }
AINgramLanguageModelTest >> setUp [
	super setUp.
	model := AINgramLanguageModel new.
]

{ #category : #tests }
AINgramLanguageModelTest >> testEmptyModelAssignsZeroCountToNgramOfRightOrder [
	| ngram |
	ngram := #(lorem ipsum) asAINgram.
	self assert: (model countOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramLanguageModelTest >> testEmptyModelHasTotalNgramCount0 [
	self assert: model totalNgramCountInText equals: 0.
]

{ #category : #tests }
AINgramLanguageModelTest >> testEmptyModelOfOrder2HasOrder2 [
	model trainOn: 'test sentence' order: 2. 
	self assert: model order equals: 2.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedBigramModelIsProbabilityDistribution [
	| text vocab ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' lorem ipsum dolor sit amet).
	
	model trainOn: text order: 2.
	
	vocab do: [ :firstWord |
		sumOfProbabilities := vocab inject: 0 into: [ :sum :secondWord |
			ngram := { firstWord . secondWord } asAINgram.
			sum + (model probabilityOfNgram: ngram) ].
		
		self assert: sumOfProbabilities equals: 1 ].
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelCounts [
	| text ngram1 ngram2 ngram3 ngram4 ngram5 |
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram1 := #('<s>' lorem) asAINgram.
	ngram2 := #(lorem ipsum) asAINgram.
	ngram3 := #(ipsum ipsum) asAINgram.
	ngram4 := #(ipsum dolor) asAINgram.
	ngram5 := #(dolor '<s>') asAINgram.
	
	model trainOn: text order: 2.
	
	self assert: (model countOfNgram: ngram1) equals: 1.
	self assert: (model countOfNgram: ngram2) equals: 1.
	self assert: (model countOfNgram: ngram3) equals: 2.
	self assert: (model countOfNgram: ngram4) equals: 1.
	self assert: (model countOfNgram: ngram5) equals: 1.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelProbabilitiesOfNgrams [
	| text ngram1 ngram2 ngram3 ngram4 ngram5 |
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram1 := #('<s>' lorem) asAINgram.
	ngram2 := #(lorem ipsum) asAINgram.
	ngram3 := #(ipsum ipsum) asAINgram.
	ngram4 := #(ipsum dolor) asAINgram.
	ngram5 := #(dolor '<s>') asAINgram.
	
	model trainOn: text order: 2.
	
	self assert: (model probabilityOfNgram: ngram1) equals: 1.
	self assert: (model probabilityOfNgram: ngram2) equals: 1.
	self assert: (model probabilityOfNgram: ngram3) equals: 2/3 asFloat.
	self assert: (model probabilityOfNgram: ngram4) equals: 1/3 asFloat.
	self assert: (model probabilityOfNgram: ngram5) equals: 1.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelProbabilityOfUnknownNgramWithKnownHistoryIs0 [
	| text ngram |
		
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(ipsum hello) asAINgram.
	
	model trainOn: text order: 2.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelProbabilityOfUnknownNgramWithUnknownHistoryIs0 [
	| text ngram |
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(world hello) asAINgram.
	
	model trainOn: text order: 2.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelSelfProbabilityOfText [
	| text |
	text := 'lorem ipsum ipsum ipsum dolor'.
	
	model trainOn: text order: 2.
	self
		assert: (model probabilityOfText: text)
		closeTo: 2/3 * 2/3 * 1/3 asFloat.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedModelSelfProbabilityOfUniformTextIs1 [
	| text |
	
	text := 'lorem ipsum dolor sit amet'.
	model trainOn: text order: 2.
	
	self assert: (model probabilityOfText: text) equals: 1.
]

{ #category : #tests }
AINgramLanguageModelTest >> testTrainedUnigramModelIsProbabilityDistribution [
	| text vocab ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' lorem ipsum dolor sit amet).
	
	model trainOn: text order: 1.
	
	sumOfProbabilities := vocab inject: 0 into: [ :sum :word |
		ngram := { word } asAINgram.
		sum + (model probabilityOfNgram: ngram).
		 ].
		
	self assert: sumOfProbabilities equals: 1.
]
