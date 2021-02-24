Class {
	#name : #AINLTKPosTagger,
	#superclass : #AIBridgeObject,
	#category : #'AI-NLP-NLTK'
}

{ #category : #private }
AINLTKPosTagger >> buildPythonScript: aString [

	^ String streamContents: [ : stream |
		stream 
			nextPutAll: 'import nltk
tokens = nltk.word_tokenize("';
			nextPutAll: aString;
			nextPutAll: '")
postags = nltk.pos_tag(tokens)
' ]
]

{ #category : #private }
AINLTKPosTagger >> raw_parse: aString [
	
	self bridge sendMessage: (self buildPythonScript: aString).
	^ self bridge getValue: 'postags'.


]
