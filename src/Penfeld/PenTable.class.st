Class {
	#name : #PenTable,
	#superclass : #PenList,
	#traits : 'TPenSections',
	#classTraits : 'TPenSections classTrait',
	#instVars : [
		'sections',
		'header',
		'showHeader',
		'dragSections'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTable class >> styleName [
	^ #table
]

{ #category : #building }
PenTable >> build [
	self stylesheet ifNil: [ self chooseStylesheet ].
	(self header isNotNil and: [self showHeader])
		ifTrue: [ self header build ].
	super build
]

{ #category : #accessing }
PenTable >> dragSections [
	^ dragSections
]

{ #category : #accessing }
PenTable >> dragSections: anObject [
	dragSections := anObject
]

{ #category : #accessing }
PenTable >> header [
	^ header
]

{ #category : #accessing }
PenTable >> header: anObject [
	header := anObject.
	anObject parent: self
]

{ #category : #initialization }
PenTable >> initialize [
	super initialize.
	sections := #().
	sortingBlock := [ :a :b | true ].
	showHeader := true.
	dragSections := false.
]

{ #category : #building }
PenTable >> refresh [
	(self header isNotNil and: [self showHeader])
		ifTrue: [ self header refresh ].
	super refresh
]

{ #category : #building }
PenTable >> refreshSectionsOrder [
	self flag: #doItBetter.
	self header ifNotNil: [ self header dresser sectionsOrderChanged: self header ].
	self items do: [ :item | item dresser sectionsOrderChanged: item ]
]

{ #category : #accessing }
PenTable >> sections [
	^ sections
]

{ #category : #accessing }
PenTable >> sections: aCollection [
	sections := aCollection
]

{ #category : #accessing }
PenTable >> showHeader [
	^ showHeader
]

{ #category : #accessing }
PenTable >> showHeader: anObject [
	showHeader := anObject
]
