Class {
	#name : #PenContainer,
	#superclass : #PenDisplayComponent,
	#instVars : [
		'elements',
		'layout'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenContainer class >> styleName [
	^ #container
]

{ #category : #accessing }
PenContainer >> addAllElements: aCollection [
	aCollection do: [ :e | self addElement: e ].
]

{ #category : #accessing }
PenContainer >> addElement: anElement [
	self addElement: anElement afterIndex: self elements size.
]

{ #category : #accessing }
PenContainer >> addElement: anElement afterIndex: anIndex [
	self elements add: anElement afterIndex: anIndex.
	anElement parent: self.
	
	self isBuilt ifFalse: [ ^ self ].
	anElement isBuilt ifFalse: [ anElement build ].
	self dresser addElement: anElement at: anIndex.
]

{ #category : #accessing }
PenContainer >> allElements [
	| collection |
	collection := self elements copy.
	self elements do: [ :element | 
		element isContainer ifTrue: [ collection addAll: element allElements ] ].
	^ collection
]

{ #category : #building }
PenContainer >> build [
	super build.
	self elements withIndexDo: [ :element :index | 
		element build: index.
		self dresser addElement: element ].
]

{ #category : #accessing }
PenContainer >> elements [
	^ elements
]

{ #category : #accessing }
PenContainer >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
PenContainer >> getElement: aKey [
	^ self allElements 
		detect: [ :element | element key = aKey ]
		ifNone: [ nil ] 
]

{ #category : #initialization }
PenContainer >> initialize [
	super initialize.
	elements := OrderedCollection new.
	layout := PenFlowLayout new.
]

{ #category : #testing }
PenContainer >> isContainer [
	^ true
]

{ #category : #accessing }
PenContainer >> layout [
	^ layout
]

{ #category : #accessing }
PenContainer >> layout: anObject [
	layout := anObject
]

{ #category : #accessing }
PenContainer >> removeAllElements [
	self elements copy do: [ :element |
		self elements remove: element ifAbsent: [ ^ self].
		self isBuilt ifTrue: [ self dresser removeElement: element ].
	].
]

{ #category : #accessing }
PenContainer >> removeElement: anElement [
	self elements remove: anElement ifAbsent: [ ^ self].
	self isBuilt ifTrue: [ self dresser removeElement: anElement ].
]

{ #category : #accessing }
PenContainer >> stylesheet: aStylesheet [
	super stylesheet: aStylesheet.
	self elements do: [ :element | element stylesheet: aStylesheet ]
]
