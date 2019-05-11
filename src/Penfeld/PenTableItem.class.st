Class {
	#name : #PenTableItem,
	#superclass : #PenInteractionElement,
	#instVars : [
		'content'
	],
	#category : #'Penfeld-Elements'
}

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

{ #category : #building }
PenTableItem >> refresh [
	self content do: [ :each | each refresh ].
	super refresh
]

{ #category : #accessing }
PenTableItem >> styleName [
	^ #tr
]

{ #category : #accessing }
PenTableItem >> table [
	^ self parent
]
