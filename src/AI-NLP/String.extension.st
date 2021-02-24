Extension { #name : #String }

{ #category : #'*AI-NLP' }
String >> asAINgram [
	^ AINgram withElements: { self }
]

{ #category : #'*AI-NLP' }
String >> ngrams: order [
	^ self tokenizeForNgrams ngrams: order
]

{ #category : #'*AI-NLP' }
String >> ngrams: order padWith: padSymbol [
	^ self tokenizeForNgrams ngrams: order padWith: padSymbol
]

{ #category : #'*AI-NLP' }
String >> removeSpecialArtifacts [

	^ self removeSpecialArtifactsUsing: AIWordTokenizer new specialArtifacts
]

{ #category : #'*AI-NLP' }
String >> removeSpecialArtifactsUsing: artifactsCollection [

	^ (self findBetweenSubstrings: artifactsCollection) joinUsing: ' '
]

{ #category : #'*AI-NLP' }
String >> stemFrom: aPGPorterStemmer [ 
	" See comment in #stemOf: "

	^ aPGPorterStemmer performStemmingFromString: self.

]

{ #category : #'*AI-NLP' }
String >> tokenize [
	" Answer a <Collection> of <String> each one representing the receiver's tokens "

	^ AIWordTokenizer new 
		tokenize: self
]

{ #category : #'*AI-NLP' }
String >> tokenizeForNgrams [
	|tokenizer|
	tokenizer := AITokenizer new.
	^ tokenizer tokenizeFlatten: self.
]

{ #category : #'*AI-NLP' }
String >> tokenizeWithoutStopwords [
	" Answer a <Collection> of <String> each one representing the receiver's tokens without stopwords "
	
	^ self tokenize 
		removeStopwordsUsing: AIStopwords forEnglish
]
