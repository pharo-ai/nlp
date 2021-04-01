Class {
	#name : #AITermDocumentMatrix,
	#superclass : #AIMatrixDecorator,
	#instVars : [
		'termMap',
		'documentMap',
		'localWeighting',
		'globalWeighting'
	],
	#category : #'AI-NLP-TFIDF'
}

{ #category : #'instance creation' }
AITermDocumentMatrix class >> empty [
	
	^self onMatrix: self matrixSpecies new
]

{ #category : #'instance creation' }
AITermDocumentMatrix class >> emptyWithRows: rows columns: columns [
	
	^self onMatrix: (self matrixSpecies rows: rows columns: columns)
]

{ #category : #'instance creation' }
AITermDocumentMatrix class >> matrixSpecies [
	
	^ AISparseRowMatrix
]

{ #category : #'instance creation' }
AITermDocumentMatrix class >> on: aVocabulary [
	
	^ self empty
		addVocabulary: aVocabulary;
		yourself
]

{ #category : #'instance creation' }
AITermDocumentMatrix class >> onMatrix: aMatrix [
	
	| tdm |
	tdm := super on: aMatrix.
	tdm initialize.
	^tdm
]

{ #category : #adding }
AITermDocumentMatrix >> addVocabulary: vocabulary [
	"adds a MalCorpus to the matrix. It creates new rows or columns to new terms and documents, respectively"
	
	vocabulary documentTermCountDo: [:document :term :count | 
		| row column |
		row := termMap
			atValue: term
			ifAbsentPut: [matrix addRow. matrix rowSize].
		column := documentMap
			atValue: document
			ifAbsentPut: [matrix addColumn. matrix columnSize].
			
		matrix at: row and: column add: count
	]
]

{ #category : #accessing }
AITermDocumentMatrix >> documentAt: element [ 

	^ self columnAt: (documentMap atValue: element)
]

{ #category : #accessing }
AITermDocumentMatrix >> documentMap [

	^ documentMap
]

{ #category : #accessing }
AITermDocumentMatrix >> documentSize [
	
	^self columnSize
]

{ #category : #accessing }
AITermDocumentMatrix >> documents [
	
	^documentMap asArray
]

{ #category : #accessing }
AITermDocumentMatrix >> frequencyOf: term in: document [
	
	^ matrix
		at: (termMap atValue: term)
		and: (documentMap atValue: document)
]

{ #category : #weighting }
AITermDocumentMatrix >> globalWeighting [
	
	^globalWeighting
]

{ #category : #weighting }
AITermDocumentMatrix >> globalWeighting: aHapGlobalWeighting [
	"sets a global weighting function, which is applied to the frequency of a term in all documents of the matrix"
	
	globalWeighting := aHapGlobalWeighting
]

{ #category : #'initialize-release' }
AITermDocumentMatrix >> initialize [
	"by default, term frequency and inverse document frequency are chosen for term weighting"
	
	termMap := AIBidirectionalMap new.
	documentMap := AIBidirectionalMap new.
	localWeighting := AITermFrequency new.
	globalWeighting := AIInverseDocumentFrequency new
]

{ #category : #weighting }
AITermDocumentMatrix >> localWeighting [
	
	^localWeighting
]

{ #category : #weighting }
AITermDocumentMatrix >> localWeighting: aHapLocalWeighting [
	"sets a local weighting function, which is applied to the frequency of a term in a single document"
	
	localWeighting := aHapLocalWeighting
]

{ #category : #removing }
AITermDocumentMatrix >> removeTermSatisfying: aBlock [
	"removes every term of this matrix that satisfies a given block. The block must return a boolean value.
	 Keep in mind that it is preferable to remove terms of the vocabulary before building the matrix, e.g.,
	 when creating a corpus. Thus, this message must be used when removing terms by their frequency.
	
	Example
		removeTermSatisfies: [ :term :row | (globalWeighting documentFrequency: row) <= threshold ]"
	
	| keep |
	keep := OrderedCollection new: matrix rowSize.
	
	matrix rows doWithIndex: [ :row :index | 
		| term |
		term := termMap atKey: index.
		(aBlock value: term value: row) ifFalse: [keep add: term -> row]].
	
	keep := (keep collect: #key) -> (keep collect: #value).
	matrix := AISparseRowMatrix onRows: keep value.
	termMap := AIBidirectionalMap withIndicesAndElements: keep key
]

{ #category : #accessing }
AITermDocumentMatrix >> termAt: term [ 

	^ self rowAt: (termMap atValue: term)
]

{ #category : #accessing }
AITermDocumentMatrix >> termMap [

	^ termMap
]

{ #category : #accessing }
AITermDocumentMatrix >> termSize [
	
	^self rowSize
]

{ #category : #accessing }
AITermDocumentMatrix >> termSizeOfDocument: document [
	"the sum of frequencies of terms in a given document"
	
	^ (self rowAt: (documentMap atValue: document)) sum
]

{ #category : #accessing }
AITermDocumentMatrix >> terms [
	
	^termMap asArray
]

{ #category : #weighting }
AITermDocumentMatrix >> weight [
	"performs both local and global weighting functions in the matrix. By default, term frequency and inverse
	 document frequency are applied. Other functions must be set by this matrix's respective set messages"
	
	| newMatrix |
	newMatrix := AISparseRowMatrix new: matrix dimension.
	
	matrix rows with: newMatrix rows do: [ :row :newRow | 
		| globalWeight |
		globalWeight := globalWeighting forTerm: row.
		row doSparseWithIndex: [ :each :index | 
			newRow at: index put: (localWeighting forValue: each) * globalWeight]
	].
	
	matrix := newMatrix
]
