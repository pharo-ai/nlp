Class {
	#name : #AIEndOfStream,
	#superclass : #Error,
	#category : #'AI-NLP-TFIDF'
}

{ #category : #exceptiondescription }
AIEndOfStream >> defaultAction [
	"Answer ReadStream>>next default reply."

	^ nil
]

{ #category : #description }
AIEndOfStream >> isResumable [
	"EndOfStream is resumable, so ReadStream>>next can answer."

	^ true
]
