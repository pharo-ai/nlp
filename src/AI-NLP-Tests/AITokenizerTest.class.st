Class {
	#name : #AITokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenizer'
	],
	#category : #'AI-NLP-Tests'
}

{ #category : #running }
AITokenizerTest >> setUp [
	super setUp.
	tokenizer := AITokenizer new.
]

{ #category : #tests }
AITokenizerTest >> testSentenceLevelTokenization [
	"Testing tokenization at a sentence level for multi sentence docs"
	| text result expected |
	text := 'This is a set of sentences. There are multiple different sentences here right?Let us teste if sentence level works!'.
	expected := #( 'This is a set of sentences.' ' There are multiple different sentences here right?' 'Let us teste if sentence level works!').
	result := tokenizer sentenceTokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testSentenceLevelTokenizationOnSingleSent [
	"Testing tokenization at a sentence level for only one sentence"
	| text result expected |
	text := 'This is a set of sentences'.
	expected := #( 'This is a set of sentences').
	result := tokenizer sentenceTokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenize [
	"The simplest example of tokenization. Split string of words separated by spaces into an array of words"
	| text result expected |
	text := 'This is a test string'.
	expected := #(#(This is a test string)).
	result := tokenizer tokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenizeFlatten [
	|result expected text|
	
	tokenizer := AIWordTokenizer new.
	text := 'This is test sentence 1. This is test sentence 2.'.
	
	expected := #('This' 'is' 'test' 'sentence' '1' 'This' 'is' 'test' 'sentence' '2').
	result := tokenizer tokenizeFlatten: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenizeWithAbbreviations [
	"Tokenize a sentence with abbreviations. Each abbreviation should be treated as a single token"
	| text result expected |
	text := 'NASA is an independent agency of the US Federal Government'.
	expected := #(#(NASA is an independent agency of the US Federal Government)).
	result := tokenizer tokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenizeWithAbbreviationsWithNumbers [
	"Tokenize a sentence with numbers. Each number should be treated as a single token"
	| text result expected |
	text := 'Here are some numbers: 42, 42.4, -0.5, 1/2, 6.02e23, -0.03E-13'.
	expected := #(#('Here' 'are' 'some' 'numbers' $: '42' $, '42.4' $, '-0.5' $, '1/2' $, '6.02e23' $, '-0.03E-13')).
	result := tokenizer tokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenizeWithApostrophe [
	"Word that has anapostrophe must be treated as a single token"
	| text result expected |
	text := 'This is Sam''s'.
	expected := #(#(This is 'Sam''s')).
	result := tokenizer tokenize: text.
	self assert: result equals: expected.
]

{ #category : #tests }
AITokenizerTest >> testTokenizeWithPunctuation [
	"Tokenize a sentence with punctuation. Every individual punctuation symbol must be considered as a separate token"
	| text result expected |
	text := 'This, this, and this are words!'.
	expected := #(#('This' $, 'this' $, 'and' 'this' 'are' 'words' $! )).
	result := (tokenizer tokenize: text).
	self assert: result equals: expected.
]
