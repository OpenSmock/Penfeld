Class {
	#name : #PenTableItem,
	#superclass : #PenInteractionElement,
	#instVars : [
		'content',
		'raw'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTableItem class >> styleName [
	^ #tr
]

{ #category : #'as yet unclassified' }
PenTableItem >> atSection: aSymbol [
	^ content at: aSymbol
]

{ #category : #'as yet unclassified' }
PenTableItem >> atSection: aSymbol put: anElement [
	self content at: aSymbol put: anElement.
	anElement parent: self
]

{ #category : #building }
PenTableItem >> build [
	self stylesheet ifNil: [ self chooseStylesheet ].
	self checkContent.
	self content do: [ :each | each build ].
	super build
]

{ #category : #validation }
PenTableItem >> checkContent [
	self table sections do: [ :section |
		content 
			at: section selector 
			ifAbsent: [ content at: section selector put: PenContainer new ] ]
]

{ #category : #accessing }
PenTableItem >> content [
	^ content
]

{ #category : #initialization }
PenTableItem >> initialize [
	super initialize.
	content := Dictionary new
]

{ #category : #private }
PenTableItem >> loopRefresh [
	super loopRefresh.
	self content valuesDo: [ :c | c loopRefresh ].
]

{ #category : #accessing }
PenTableItem >> raw [
	^ raw
]

{ #category : #accessing }
PenTableItem >> raw: anObject [
	raw := anObject
]

{ #category : #building }
PenTableItem >> refresh [
	self content do: [ :each | each refresh ].
	super refresh
]

{ #category : #accessing }
PenTableItem >> table [
	^ self parent
]
