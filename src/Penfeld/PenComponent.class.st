Class {
	#name : #PenComponent,
	#superclass : #Object,
	#traits : 'TPenIdentifiable',
	#classTraits : 'TPenIdentifiable classTrait',
	#instVars : [
		'key',
		'description',
		'eventBindings',
		'enabled',
		'position',
		'size'
	],
	#category : #'Penfeld-Components'
}

{ #category : #'instance creation' }
PenComponent class >> key: aSymbol [
	^ self new key: aSymbol
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

{ #category : #testing }
PenComponent >> hasEvents [
	^ eventBindings notEmpty
]

{ #category : #accessing }
PenComponent >> height [ 
	^ self size
		ifNil: [ 0 ] 
		ifNotNil: [ self size y ]
]

{ #category : #accessing }
PenComponent >> height: aNumber [
	self size ifNil: [ self size: 0@aNumber].
	self size setX: (self size x) setY: aNumber
]

{ #category : #initialization }
PenComponent >> initialize [
	super initialize.
	enabled := true.
	eventBindings := OrderedCollection new.
	position := 0@0
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
PenComponent >> onActionDo: aBlock [
	self onEvent: PenEventSymbol action do: aBlock
]

{ #category : #'api - events' }
PenComponent >> onActionPerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol action perform: aSymbol on: aReceiver
]

{ #category : #'api - events' }
PenComponent >> onClickDo: aBlock [
	self onEvent: PenEventSymbol click do: aBlock
]

{ #category : #'api - events' }
PenComponent >> onClickPerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol click perform: aSymbol on: aReceiver
]

{ #category : #'api - events' }
PenComponent >> onEvent: anEventSymbol do: aBlock [
	| binding |
	binding := PenEventBinding for: anEventSymbol do: aBlock.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenComponent >> onEvent: anEventSymbol perform: aSymbol on: aReceiver [
	| binding |
	binding := PenEventBinding for: anEventSymbol perform: aSymbol on: aReceiver.
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
PenComponent >> onEvents: aListOfSymbols perform: aSymbol on: aReceiver [
	| binding |
	binding := PenEventBinding forAll: aListOfSymbols perform: aSymbol on: aReceiver.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenComponent >> onMouseDownDo: aBlock [
	self onEvent: PenEventSymbol mouseDown do: aBlock
]

{ #category : #'api - events' }
PenComponent >> onMouseDownPerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol mouseDown perform: aSymbol on: aReceiver
]

{ #category : #'api - events' }
PenComponent >> onResizeDo: aBlock [
	self onEvent: PenEventSymbol resize do: aBlock
]

{ #category : #'api - events' }
PenComponent >> onResizePerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol resize perform: aSymbol on: aReceiver
]

{ #category : #accessing }
PenComponent >> position [
	^ position
]

{ #category : #accessing }
PenComponent >> position: aPoint [
	position = aPoint ifTrue: [ ^ self ].
	position := aPoint.
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

{ #category : #'api - events' }
PenComponent >> removeAllEvents [
	eventBindings := OrderedCollection new.
]

{ #category : #events }
PenComponent >> resizeEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol resize)
			ifTrue: [ eventBinding executeCallback ]].
]

{ #category : #accessing }
PenComponent >> size [
	^ size
]

{ #category : #accessing }
PenComponent >> size: aSize [
	size := aSize.
	size when: #resize send: #resizeEvent to: self.
	self resizeEvent.
]

{ #category : #accessing }
PenComponent >> width [ 
	^ self size
		ifNil: [ 0 ] 
		ifNotNil: [ self size x ]
]

{ #category : #accessing }
PenComponent >> width: aNumber [
	self size ifNil: [ self size: aNumber@0 ].
	self size setX: aNumber setY: self size y
]
