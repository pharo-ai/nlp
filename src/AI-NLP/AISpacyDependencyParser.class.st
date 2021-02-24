Class {
	#name : #AISpacyDependencyParser,
	#superclass : #AIBridgeObject,
	#category : #'AI-NLP-Spacy'
}

{ #category : #private }
AISpacyDependencyParser >> buildPythonScript: aString [

	^ String streamContents: [ : stream |
		stream 
			nextPutAll: 'import spacy

nlp = spacy.load("en")
relations = []
doc = nlp("';
			nextPutAll: aString;
			nextPutAll: '")
for token in doc:
	pair = []
	pair.append(token.text)
	pair.append(token.dep_)
	pair.append(token.head.text)
	relations.append(pair)'. ]
]

{ #category : #accessing }
AISpacyDependencyParser >> raw_parse: aString [

	| dependencyParseString |
	
	self bridge sendMessage: (self buildPythonScript: aString).
	dependencyParseString := self bridge getValue: 'relations'.
	^ dependencyParseString
]
