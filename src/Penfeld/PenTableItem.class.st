Class {
	#name : #PenTableItem,
	#superclass : #PenInteractionElement,
	#instVars : [
		'content'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #building }
PenTableItem >> build [
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

{ #category : #'as yet unclassified' }
PenTableItem >> contentAtSection: aSymbol [
	^ content at: aSymbol
]

{ #category : #'as yet unclassified' }
PenTableItem >> forSection: aSymbol put: aContainer [
	| container |
	container := aContainer isContainer
		ifTrue: [ aContainer ]
		ifFalse: [ PenContainer new addElement: aContainer ].
	self content at: aSymbol put: container.
	container parent: self
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
	^ #tableItem
]

{ #category : #accessing }
PenTableItem >> table [
	^ self parent
]
