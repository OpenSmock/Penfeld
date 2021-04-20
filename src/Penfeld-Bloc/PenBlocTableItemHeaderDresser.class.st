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
PenBlocTableItemHeaderDresser >> dragEnd: anEvent on: aComponent [
	| dragEndPosition sections delta i |
	anEvent consumed: true.
	dragEndPosition := anEvent position.
	sections := aComponent parent sections.
	i := sections indexOf: draggedSection.
	
	delta := dragEndPosition - dragStartPosition.
	delta x > 0
		ifTrue: [ 
			"right drag"
			[i < sections size] whileTrue: [ 
				| boundsInSpace middle |
				i := i + 1.
				boundsInSpace := (aComponent content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2  + boundsInSpace origin x.
				dragEndPosition x > middle ifTrue: 
					[ aComponent parent moveSection: draggedSection after: (sections at: i) ]]]
		ifFalse: [ 
			"left drag"
			[i > 1] whileTrue: [ 
				| boundsInSpace middle |
				i := i - 1.
				boundsInSpace := (aComponent content at: (sections at: i) selector) engineElement boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2 + boundsInSpace origin x.
				dragEndPosition x < middle ifTrue: 
					[ aComponent parent moveSection: draggedSection before: (sections at: i) ]]]
]

{ #category : #events }
PenBlocTableItemHeaderDresser >> dragStart: anEvent on: aComponent [
	| draggedSelector |
	anEvent consumed: true.
	dragStartPosition := anEvent position.
	aComponent content keysAndValuesDo: [ :key :value |
		(value engineElement containsGlobalPoint: dragStartPosition)
			ifTrue: [ draggedSelector := key ]].
	draggedSection := aComponent parent sections detect: [ :section |
		section selector = draggedSelector ].
]

{ #category : #dressing }
PenBlocTableItemHeaderDresser >> initEngineElementFor: aComponent [
	super initEngineElementFor: aComponent.
	
	aComponent parent dragSections ifFalse: [ ^self ].
	
	aComponent engineElement children do: [ :each |
		each when: BlDragStartEvent do: [ :e | self dragStart: e on: aComponent ].
		each when: BlDragEndEvent do: [ :e | self dragEnd: e on: aComponent] ]
]
