"
Name: AIAtlasBridge

Users: 
 - AIBridgeObject

Used: 
 - SocketStream
 - AIAtlasBridge

Public methods:
 - getValue:
 - host
 - sendCommand:
 - defaultPort
 - port:
 - stream:
 - sendMessage:
 - stream
 - port

Keywords: message socket, python
"
Class {
	#name : #AIAtlasBridge,
	#superclass : #Object,
	#instVars : [
		'port',
		'stream',
		'host'
	],
	#classInstVars : [
		'port'
	],
	#category : #'AI-NLP-Core'
}

{ #category : #visiting }
AIAtlasBridge >> acceptConnection [
	| errString |
	
	errString := ''.
	[ 
		errString := self stream nextLineLf.
		('received : ', errString) crTrace. 
		self error: errString 
	] fork.
	self stream close.
]

{ #category : #defaults }
AIAtlasBridge >> defaultHost [

	^ '127.0.0.1' 
]

{ #category : #defaults }
AIAtlasBridge >> defaultPort [

	^ 4000
]

{ #category : #accessing }
AIAtlasBridge >> getValue: aString [
	"similar to sendMessage but this method also return the python value "

	| errString retValue |

	self sendCommand: 'RetValue: ', aString.
	errString := stream nextLineLf .
	[ errString matchesRegex: '.*end of error.*' ] whileFalse:[
		('iterating with error:', errString) crTrace.
		(errString matchesRegex:  '.*no error.*') ifFalse: [  
			(errString matchesRegex: '.*end of error.*') ifFalse:[
				(errString matchesRegex: '') ifFalse: [
					(errString matchesRegex: 'RetValue\:.*') ifTrue: [
						(' I am getting error:' , errString) crTrace.
				(errString regex: '[^(RetValue:)].*'  matchesDo: [ :word|  
					('Returned' , word) crTrace. 
					retValue := word]) .
				^ retValue] 
			ifFalse: [ self error: errString ] ] ] ].
	errString := stream nextLineLf ].
	stream close.
]

{ #category : #accessing }
AIAtlasBridge >> host [

	^ host
		ifNil: [ host := self defaultHost ]
]

{ #category : #initialization }
AIAtlasBridge >> initializeSocketStream [

	^ SocketStream 
		openConnectionToHostNamed: self host
		port: self port.
]

{ #category : #private }
AIAtlasBridge >> isErrorResponse: aString [

	^ aString matchesRegex: '.*end of error.*'
]

{ #category : #accessing }
AIAtlasBridge >> port [
	"Return the port where the TCP echo service runs"
	^ port
		ifNil: [ port := self defaultPort ]
]

{ #category : #accessing }
AIAtlasBridge >> port: anObject [
	port := anObject
]

{ #category : #private }
AIAtlasBridge >> sendCommand: aString [

	self stream sendCommand: aString
]

{ #category : #private }
AIAtlasBridge >> sendMessage: aString [

	| errString |

	self sendCommand: aString.
	errString := stream nextLineLf.
	[ self isErrorResponse: aString ] whileFalse: [
		(errString matchesRegex:  '.*no error.*') ifFalse: [  
			(errString matchesRegex: '.*end of error.*') ifFalse:[
				(errString matchesRegex: '') ifFalse: [ self error: errString ] ] ].
		errString:= stream nextLineLf ].
	stream close.

]

{ #category : #accessing }
AIAtlasBridge >> stream [

	^ stream
		ifNil: [ stream := self initializeSocketStream ]
]

{ #category : #accessing }
AIAtlasBridge >> stream: anObject [
	stream := anObject
]
