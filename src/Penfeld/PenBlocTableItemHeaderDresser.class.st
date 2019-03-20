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
	sections := self model parent sections.
	i := sections indexOf: draggedSection.
	
	delta := dragEndPosition - dragStartPosition.
	delta x > 0
		ifTrue: [ 
			"right drag"
			[i < sections size] whileTrue: [ 
				| boundsInSpace middle |
				i := i + 1.
				boundsInSpace := (self model content at: (sections at: i) selector) interactor boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2  + boundsInSpace origin x.
				dragEndPosition x > middle ifTrue: 
					[ self model parent moveSection: draggedSection after: (sections at: i) ]]]
		ifFalse: [ 
			"left drag"
			[i > 1] whileTrue: [ 
				| boundsInSpace middle |
				i := i - 1.
				boundsInSpace := (self model content at: (sections at: i) selector) interactor boundsInSpace.
				middle := (boundsInSpace corner x - boundsInSpace origin x) / 2 + boundsInSpace origin x.
				dragEndPosition x < middle ifTrue: 
					[ self model parent moveSection: draggedSection before: (sections at: i) ]]]
]

{ #category : #events }
PenBlocTableItemHeaderDresser >> dragStart: anEvent [
	| draggedSelector |
	anEvent consumed: true.
	dragStartPosition := anEvent position.
	self model content keysAndValuesDo: [ :key :value |
		(value interactor containsGlobalPoint: dragStartPosition)
			ifTrue: [ draggedSelector := key ]].
	draggedSection := self model parent sections detect: [ :section |
		section selector = draggedSelector ].
]

{ #category : #dressing }
PenBlocTableItemHeaderDresser >> initInteractor [
	super initInteractor.
	
	self model parent dragSections ifFalse: [ ^self ].
	
	self model interactor children do: [ :each |
		each when: BlDragStartEvent do: [ :e | self dragStart: e ].
		each when: BlDragEndEvent do: [ :e | self dragEnd: e ] ]
]
