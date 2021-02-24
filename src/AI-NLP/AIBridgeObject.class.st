Class {
	#name : #AIBridgeObject,
	#superclass : #Object,
	#instVars : [
		'bridge'
	],
	#category : #'AI-NLP-Core'
}

{ #category : #accessing }
AIBridgeObject >> bridge [
	^ bridge
		ifNil: [ bridge := self defaultBridge ]
]

{ #category : #accessing }
AIBridgeObject >> bridge: anObject [
	bridge := anObject
]

{ #category : #defaults }
AIBridgeObject >> defaultBridge [

	^ AIAtlasBridge new
]
