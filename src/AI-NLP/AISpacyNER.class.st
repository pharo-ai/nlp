Class {
	#name : #AISpacyNER,
	#superclass : #AIBridgeObject,
	#category : #'AI-NLP-Spacy'
}

{ #category : #private }
AISpacyNER >> buildPythonScript: aString [

	^ String streamContents: [ : stream |
		stream 
			nextPutAll: 'import spacy

nlp = spacy.load("en")
ents = []
doc = nlp("';
			nextPutAll: aString;
			nextPutAll: '")
for ent in doc.ents:
	pair = {}
	pair[ent.text] = ent.label_
	ents.append(pair).' ]
]

{ #category : #accessing }
AISpacyNER >> raw_parse: aString [

	| nerString |

	self bridge sendMessage: (self buildPythonScript: aString).
	nerString := self bridge getValue: 'ents'.
	^nerString
]
