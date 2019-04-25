Class {
	#name : #PenComponent,
	#superclass : #Object,
	#traits : 'TPenDebug + TPenIdentifiable',
	#classTraits : 'TPenDebug classTrait + TPenIdentifiable classTrait',
	#instVars : [
		'key',
		'description',
		'eventBindings',
		'enabled'
	],
	#category : #'Penfeld-Components'
}

{ #category : #'instance creation' }
PenComponent class >> key: aSymbol [
	^ self basicNew initialize; key: aSymbol
]

{ #category : #accessing }
PenComponent >> description [
	^ description
]

{ #category : #accessing }
PenComponent >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PenComponent >> disable [
	self enabled: false
]

{ #category : #accessing }
PenComponent >> enable [
	self enabled: true
]

{ #category : #accessing }
PenComponent >> enabled: aBoolean [
	enabled = aBoolean ifTrue: [ ^ self ].
	
	enabled := aBoolean.
	enabled 
		ifTrue: [ 
			self deactivatePseudoClass: #disabled.
			self activatePseudoClass: #enabled. ]
		ifFalse: [ 
			self deactivatePseudoClass: #enabled.
			self activatePseudoClass: #disabled ]
]

{ #category : #'private-accessing' }
PenComponent >> eventBindings [
	^ eventBindings
]

{ #category : #initialization }
PenComponent >> initialize [
	enabled := true.
	eventBindings := OrderedCollection new.
]

{ #category : #testing }
PenComponent >> isDisabled [
	^ enabled not
]

{ #category : #testing }
PenComponent >> isEnabled [
	^ enabled
]

{ #category : #accessing }
PenComponent >> key [
	^ key
]

{ #category : #accessing }
PenComponent >> key: anObject [
	key := anObject
]

{ #category : #'api - events' }
PenComponent >> onEvent: aSymbol do: aBlock [
	| binding |
	binding := PenEventBinding for: aSymbol do: aBlock.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenComponent >> onEvent: aSymbol perform: aFunction on: aPerformer [
	| binding |
	binding := PenEventBinding for: aSymbol perform: aFunction on: aPerformer.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenComponent >> onEvents: aListOfSymbols do: aBlock [
	| binding |
	binding := PenEventBinding forAll: aListOfSymbols do: aBlock.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenComponent >> onEvents: aListOfSymbols perform: aFunction on: aPerformer [
	| binding |
	binding := PenEventBinding forAll: aListOfSymbols perform: aFunction on: aPerformer.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #printing }
PenComponent >> printOn: aStream [
	aStream nextPutAll: self className.
	self key ifNotNil: [ 
		aStream
			nextPutAll: ': ';
			nextPutAll: 	self key printString
	 ]
]
