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
	self elements add: anElement.
	anElement parent: self.
	
	self isBuilt ifFalse: [ ^ self ].
	anElement isBuilt ifFalse: [ anElement build ].
	self dresser addElement: anElement.
	
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
PenContainer >> removeElement: anElement [
	self elements remove: anElement ifAbsent: [ ^ self].
	self dresser removeElement: anElement.
]
