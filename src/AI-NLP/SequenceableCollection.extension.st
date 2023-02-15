Extension { #name : #SequenceableCollection }

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
