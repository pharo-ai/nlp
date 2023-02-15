Extension { #name : #SequenceableCollection }

{ #category : #'*AI-NLP' }
SequenceableCollection >> asAINgram [
	^ AINgram withElements: self
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> stemFrom: aPGPorterStemmer [ 
	" See comment in #stemOf: "

	^ aPGPorterStemmer performStemmingFromSequenceableCollection: self.

]

{ #category : #'*AI-NLP' }
SequenceableCollection >> stemUsingPorter [
	" Answer a <Collection> of stemmed terms using the Porter algorithm "

	^ self collect: [ : obj | AIPorterStemmer stemOf: obj ]
]

{ #category : #'*AI-NLP' }
SequenceableCollection >> tokenizeWithoutStopwords [
	" Answer a <Collection> of <String> each one representing the receiver's tokens without stopwords "

	^ self collectDisplayingProgress: #tokenizeWithoutStopwords.

]
