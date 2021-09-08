"
Name: PGWordTokenizer

Implements punctuation aware word tokenization. Set beSkipSpecial to consider special characters.

Users: 
 - PGTokenizerTest
 - String

Used: 
 - OrderedCollection
 - PGTokenizer
 - PGWordTokenizer
 - ReadStream
 - String
 - WriteStream

Public methods:
 - tokenize:
 - wordTokenize:
 - defaultSpecialCharset

Keywords: tokenize
"
Class {
	#name : #AIWordTokenizer,
	#superclass : #AITokenizer,
	#instVars : [
		'skipSpecial'
	],
	#classVars : [
		'SpecialArtifacts'
	],
	#category : #'AI-NLP-Tokenizer'
}

{ #category : #defaults }
AIWordTokenizer class >> emojisAndHtmlCharacters [
	" Answer a <Collection> of <String> commonly found in HTML text "

	^ #('<br />' ':-)' ':-(' ':)' ':(' )
]

{ #category : #defaults }
AIWordTokenizer class >> garbageCharacters [
	" Generate them in reverse order so larger occurrences can be detected first. (on hold - #reversed - until https://github.com/pharo-project/pharo/issues/6191 gets fixed) "

	| garbageCharacters |
	garbageCharacters := ((#( $- $! $? $* $( $) $\ $/ $| $_ $# $> $< $% $$ $, $. $") 
		collect: [ :repChar | (2 to: 10) "reversed" collect: [ :rep | String new: rep withAll: repChar ] ])
			joinUsing: Array empty).
	^ garbageCharacters asArray
]

{ #category : #initialization }
AIWordTokenizer class >> initializeSpecialArtifacts [

	^ Array streamContents: [ : stream | 
		stream 
			<< self emojisAndHtmlCharacters;
			<< self garbageCharacters ]
]

{ #category : #initialization }
AIWordTokenizer class >> reset [
	<script>

	SpecialArtifacts := nil.

]

{ #category : #accessing }
AIWordTokenizer class >> specialArtifacts [
	" Answer a <Collection> of <String> representing artifacts commonly found in natural language written text. "

	^ SpecialArtifacts 
		ifNil: [ 
			SpecialArtifacts := self initializeSpecialArtifacts.
			SpecialArtifacts ].

]

{ #category : #accessing }
AIWordTokenizer >> beSkipSpecial [
	" Set the receiver to skip special characters from the resulting tokens "

	skipSpecial := true
]

{ #category : #defaults }
AIWordTokenizer >> defaultSpecialCharset [
	" Answer a <String> with Character(s) to be considered as special for the receiver "

	^ '+\*~<>=@,%|&?!(){}[]:;."''-'
]

{ #category : #initialization }
AIWordTokenizer >> initialize [
	" Private - Initialize the receiver's state to consider special word tokenizers "

	super initialize.
	self beSkipSpecial.	
]

{ #category : #accessing }
AIWordTokenizer >> isSkipSpecial [
	" Answer a <Boolean>. If <false>, special characters are added into collected tokens "

	^ skipSpecial
		ifNil: [ skipSpecial := false ]
]

{ #category : #testing }
AIWordTokenizer >> nextIsInvalid: aStream [
	" Private - Answer <true> if the next character from aStream is invalid. Skip special characters from aStream if receiver's was set to do it "

	[ aStream atEnd not and: [ self isSkipSpecial and: [ self isSpecial: aStream peek ] ] ]
		whileTrue: [ aStream skip: 1 ].
	^ aStream atEnd
]

{ #category : #tokenizing }
AIWordTokenizer >> tokenize: aDocOrString [
	" Consider a aDocOrString tokenizable by spaces. Answer a <Collection> of <String> each one a token "

	^ self wordTokenize: aDocOrString
]

{ #category : #tokenizing }
AIWordTokenizer >> wordTokenize: aString [
	" Private - Tokenize aString into wordCollection. Answer a <Collection> of <String> with tokenized words.  "

	| streamPointer cur word wordCollection |

	streamPointer := ReadStream on: aString.
	word := WriteStream on: String new.
	wordCollection := OrderedCollection new.

	[ self nextIsInvalid: streamPointer ] whileFalse: [ 
			word nextPut: (cur := streamPointer next).

			streamPointer peek isNotNil
				ifTrue: [ 
					streamPointer peek isSeparator
						ifTrue: [ 
							wordCollection add: word contents trimBoth. 
							streamPointer next. 
							word := WriteStream on: String new.]].
				
			(self isSpecial: streamPointer peek)
				ifTrue: [  
					word isEmpty 
						ifFalse: [ wordCollection add: word contents trimBoth ].
					self isSkipSpecial	
						ifFalse: [ wordCollection add: streamPointer next trimBoth ]. 
					word := WriteStream on: String new. ].
				
			cur isSeparator
				ifTrue: [ word := WriteStream on: String new ] ] .
	word isEmpty 
		ifFalse: [ wordCollection add: word contents trimBoth ].
	^ wordCollection asArray.
]
