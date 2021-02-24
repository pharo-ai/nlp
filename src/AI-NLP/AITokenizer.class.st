"
Implements a sentence based tokenizer. A sentence is any text between one of the following separators

$. $? $! followed by a Character space.

If you want to tokenize each word removing any separators and special characters, check PGWordTokenizer.

Public API and Key Messages

- tokenize: 
- tokenizeFlatten: 

Internal Representation and Key Implementation Points.

Instance Variables
	specialCharset:		<Object>


    Implementation Points
"
Class {
	#name : #AITokenizer,
	#superclass : #Object,
	#instVars : [
		'specialCharset'
	],
	#category : #'AI-NLP-Tokenizer'
}

{ #category : #defaults }
AITokenizer >> defaultSpecialCharset [
	" Answer a <String> with Character(s) to be considered as special for the receiver "

	^ '+\*~<>=@,%|&?!(){}[]:;' 
]

{ #category : #testing }
AITokenizer >> isSpecial: char [
	" Answer whether the receiver is one of the special characters "

	^ self specialCharset includes: char
]

{ #category : #tokenizing }
AITokenizer >> sentenceTokenize: aString [
	| streamPointer cur sent sentenceCollection |
	streamPointer := ReadStream on: aString.
	sent := WriteStream on: String new.
	sentenceCollection := OrderedCollection new.

	[ streamPointer atEnd ] whileFalse: [ 
			cur := streamPointer next.
			sent nextPut: cur.
			(( cur = $? or: cur = $!) or: (cur = $. and: streamPointer peek = $ ))
				ifTrue: [ 
					sentenceCollection add: sent contents. 
					sent := WriteStream on: String new ] ].
	sent isEmpty 
		ifFalse: [ sentenceCollection add: sent contents ].
	^ sentenceCollection asArray.
]

{ #category : #accessing }
AITokenizer >> specialCharset [
	" Answer a <String> containing the receiver's special Character(s) "

	^ specialCharset
		ifNil: [ specialCharset := self defaultSpecialCharset ]
]

{ #category : #accessing }
AITokenizer >> specialCharset: aString [

	specialCharset := aString
]

{ #category : #parsing }
AITokenizer >> tokenize: aDocOrString [
	" Consider a Sequence to be whatever is between $., $? or $!, followed by a space. "

	^ (self sentenceTokenize: aDocOrString) collect: [ :each | self wordTokenize: each ]
]

{ #category : #tokenizing }
AITokenizer >> tokenizeFlatten: aDocOrString [
	|sentences|
	sentences := self sentenceTokenize: aDocOrString.
	^ (sentences collect: [ :each | self wordTokenize: each ]) flatCollect: [ :e | e ]
]

{ #category : #tokenizing }
AITokenizer >> wordTokenize: aString [
	| streamPointer cur word wordCollection |
	
	streamPointer := ReadStream on: aString.
	word := WriteStream on: String new.
	wordCollection := OrderedCollection new.

	[ streamPointer atEnd ] whileFalse: [ 
			cur := streamPointer next.
			word nextPut: cur.

			streamPointer peek isNotNil
				ifTrue: [ 
					streamPointer peek isSeparator
						ifTrue: [ 
							wordCollection add: word contents. 
							streamPointer next. 
							word := WriteStream on: String new.]].
				
			(self isSpecial: streamPointer peek)
				ifTrue: [  
					wordCollection add: word contents. 
					wordCollection add: streamPointer next. 
					word := WriteStream on: String new. ].
				
			cur isSeparator
				ifTrue: [ word := WriteStream on: String new ] ] .
	word isEmpty 
		ifFalse: [ wordCollection add: word contents ].
	^ wordCollection asArray.
]
