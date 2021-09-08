"
An AITermsTest is a test class for testing the behavior of AITerms
"
Class {
	#name : #AITermsTest,
	#superclass : #TestCase,
	#instVars : [
		'terms'
	],
	#category : #'AI-NLP-Tests-TFIDF'
}

{ #category : #test }
AITermsTest >> sampleTextEnglish [

	^ 'If the night turned cold and the stars looked down
And you hug yourself on the cold cold ground
You wake the morning in a stranger''s coat
No one would you see
You ask yourself, who''d watch for me
My only friend, who could it be
It''s hard to say it
I hate to say it, but it''s probably me'
]

{ #category : #test }
AITermsTest >> sampleTextFrench [

	^ 'Ménilmontant mais oui madame
C''est là que j''ai laissé mon cœur
C''est là que je viens retrouver mon âme
Toute ma flamme
Tout mon bonheur'
]

{ #category : #test }
AITermsTest >> sampleTextSpanish [

	^ 'No vuelvas
no vuelvas sin razón
no vuelvas
estaré a un millón de años luz'
]

{ #category : #running }
AITermsTest >> setUp [
	
	super setUp.
	terms := AITerms new.
]

{ #category : #accessing }
AITermsTest >> terms [

	^ terms
]

{ #category : #accessing }
AITermsTest >> terms: anObject [

	terms := anObject
]

{ #category : #test }
AITermsTest >> testAddString [

	self assertEmpty: self terms.
	self assert: ((self terms addString: self sampleTextEnglish) isKindOf: AITerms).
	self denyEmpty: self terms.

	self assertCollection: self terms hasSameElements: #('yourself' 'yourself' 'yourself' 'yourself' 'cold' 'cold' 'cold' 'cold' 'cold' 'cold' 'stars' 'stars' 'who' 'who' 'who' 'who' 'if' 'if' 'hate' 'hate' 'i' 'i' 'only' 'only' 'be' 'be' 'it' 'it' 'it' 'it' 'it' 'it' 'it' 'it' 'it' 'it' 'my' 'my' 'say' 'say' 'say' 'say' 'probably' 'probably' 'one' 'one' 'ask' 'ask' 'morning' 'morning' 'd' 'd' 'down' 'down' 'hard' 'hard' 's' 's' 's' 's' 's' 's' 'looked' 'looked' 'and' 'and' 'and' 'and' 'the' 'the' 'the' 'the' 'the' 'the' 'the' 'the' 'but' 'but' 'in' 'in' 'friend' 'friend' 'a' 'a' 'coat' 'coat' 'would' 'would' 'hug' 'hug' 'ground' 'ground' 'night' 'night' 'me' 'me' 'me' 'me' 'you' 'you' 'you' 'you' 'you' 'you' 'you' 'you' 'wake' 'wake' 'on' 'on' 'no' 'no' 'stranger' 'stranger' 'for' 'for' 'to' 'to' 'to' 'to' 'see' 'see' 'turned' 'turned' 'watch' 'watch' 'could' 'could')
]

{ #category : #test }
AITermsTest >> testRemoveStopwords [

	| expected |
	
	self terms 
		removeAll;
		useStopwordsForEnglish;
		addString: self sampleTextEnglish.
	expected := #('cold' 'cold' 'cold' 'stars' 'hate' 'morning' 'hard' 'looked' 'friend' 'coat' 'night' 'hug' 'ground' 'wake' 'stranger' 'turned' 'watch').
	self assertCollection: self terms removeStopwords hasSameElements: expected.
	
	self terms 
		removeAll;
		useStopwordsForFrench;
		addString: self sampleTextFrench.
	expected := #('cœur' 'toute' 'j' 'oui' 'âme' 'ai' 'madame' 'viens' 'ménilmontant' 'tout' 'laissé' 'c' 'c' 'bonheur' 'flamme' 'retrouver' 'ma').
	self assertCollection: self terms removeStopwords hasSameElements: expected.

	self terms 
		removeAll;
		useStopwordsForSpanish;
		addString: self sampleTextSpanish.
	expected := #('vuelvas' 'vuelvas' 'vuelvas' 'razón' 'estaré' 'luz' 'años' 'millón').
	self assertCollection: self terms removeStopwords hasSameElements: expected.
]

{ #category : #test }
AITermsTest >> testStopwords [

	self assert: (self terms stopwords isKindOf: Collection).
	self denyEmpty: self terms stopwords.
	
	self assert: (self terms stopwords first isKindOf: String).
	self denyEmpty: self terms stopwords first.
]
