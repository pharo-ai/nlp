Class {
	#name : #AITfIdfVectorizer,
	#superclass : #AITermFrequencyInverseDocumentFrequency,
	#category : #'AI-NLP-TFIDF'
}

{ #category : #accessing }
AITfIdfVectorizer >> transform: aCollectionOfDocuments [ 
	" Transform receiver's documents to document-term matrix. Answer a Tf-idf-weighted document-term matrix "
	
	| corpus |

	corpus := AICorpus new.
	aCollectionOfDocuments doWithIndex: [: doc : index |
		corpus 
			addDocument: index asString
			with: (AITerms fromString: doc)].
	^ AITermDocumentMatrix on: corpus.

]
