Class {
	#name : #PenBlocTableItemHeaderDresser,
	#superclass : #PenBlocTableItemDresser,
	#instVars : [
		'draggedSection',
		'dragStartPosition'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #events }
PenBlocTableItemHeaderDresser >> dragEnd: anEvent [
	| dragEndPosition sections delta i |
	anEvent consumed: true.
	dragEndPosition := anEvent position.
	sections := self component parent sections.
	i := sections indexOf: draggedSection.
	
	delta := dragEndPosition - dragStartPosition.
	delta x > 0
		ifTrue: [ 
			"right drag"
			[i < sections size] whileTrue: [ 
				| boundsInSpace middle |
				i := i + 1.
				boundsInSpace := (self component content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2  + boundsInSpace origin x.
				dragEndPosition x > middle ifTrue: 
					[ self component parent moveSection: draggedSection after: (sections at: i) ]]]
		ifFalse: [ 
			"left drag"
			[i > 1] whileTrue: [ 
				| boundsInSpace middle |
				i := i - 1.
				boundsInSpace := (self component content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2 + boundsInSpace origin x.
				dragEndPosition x < middle ifTrue: 
					[ self component parent moveSection: draggedSection before: (sections at: i) ]]]
]

{ #category : #events }
PenBlocTableItemHeaderDresser >> dragStart: anEvent [
	| draggedSelector |
	anEvent consumed: true.
	dragStartPosition := anEvent position.
	self component content keysAndValuesDo: [ :key :value |
		(value engineElement containsGlobalPoint: dragStartPosition)
			ifTrue: [ draggedSelector := key ]].
	draggedSection := self component parent sections detect: [ :section |
		section selector = draggedSelector ].
]

{ #category : #dressing }
PenBlocTableItemHeaderDresser >> initEngineElement [
	super initEngineElement.
	
	self component parent dragSections ifFalse: [ ^self ].
	
	self component engineElement children do: [ :each |
		each when: BlDragStartEvent do: [ :e | self dragStart: e ].
		each when: BlDragEndEvent do: [ :e | self dragEnd: e ] ]
]
