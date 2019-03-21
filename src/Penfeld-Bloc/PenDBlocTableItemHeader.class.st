Class {
	#name : #PenDBlocTableItemHeader,
	#superclass : #PenDBlocTableItem,
	#instVars : [
		'draggedSection',
		'dragStartPosition'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTableItemHeader class >> styleSelector [
	^ #th
]

{ #category : #events }
PenDBlocTableItemHeader >> dragEnd: anEvent [
	| dragEndPosition sections delta i |
	anEvent consumed: true.
	dragEndPosition := anEvent position.
	sections := self model parent sections.
	i := sections indexOf: draggedSection.
	
	delta := dragEndPosition - dragStartPosition.
	delta x > 0
		ifTrue: [ 
			"right drag"
			[i < sections size] whileTrue: [ 
				| boundsInSpace middle |
				i := i + 1.
				boundsInSpace := (self model content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2  + boundsInSpace origin x.
				dragEndPosition x > middle ifTrue: 
					[ self model parent moveSection: draggedSection after: (sections at: i) ]]]
		ifFalse: [ 
			"left drag"
			[i > 1] whileTrue: [ 
				| boundsInSpace middle |
				i := i - 1.
				boundsInSpace := (self model content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2 + boundsInSpace origin x.
				dragEndPosition x < middle ifTrue: 
					[ self model parent moveSection: draggedSection before: (sections at: i) ]]]
]

{ #category : #events }
PenDBlocTableItemHeader >> dragStart: anEvent [
	| draggedSelector |
	anEvent consumed: true.
	dragStartPosition := anEvent position.
	self model content keysAndValuesDo: [ :key :value |
		(value engineElement containsGlobalPoint: dragStartPosition)
			ifTrue: [ draggedSelector := key ]].
	draggedSection := self model parent sections detect: [ :section |
		section selector = draggedSelector ].
]

{ #category : #initialization }
PenDBlocTableItemHeader >> initEngineElement [
	super initEngineElement.
	
	self model parent dragSections ifFalse: [ ^self ].
	
	self model engineElement children do: [ :each |
		each when: BlDragStartEvent do: [ :e | self dragStart: e ].
		each when: BlDragEndEvent do: [ :e | self dragEnd: e ] ]
]
