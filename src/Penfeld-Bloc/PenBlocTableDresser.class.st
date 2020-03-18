Class {
	#name : #PenBlocTableDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTableDresser >> initEngineElementFor: aComponent [
	| listElements |
	dataSource := PenInfiniteDataSource new.
	
	aComponent engineElement: PenInfiniteListElement new.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	listElements := aComponent items collect: [ :item | 
		item engineElement ].
	aComponent header ifNotNil: [ 
		listElements addFirst: aComponent header engineElement
	].
	dataSource elements: listElements.
	aComponent engineElement dataSource: dataSource.
	
	aComponent allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	aComponent items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
]

{ #category : #events }
PenBlocTableDresser >> whenMouseDownEventOn: anItem [ 
	anItem activatePseudoClass: #active.
	anItem refresh.
	pushedItem := anItem.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem deactivatePseudoClass: #active.
	anItem refresh.
	pushedItem := nil.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem deactivatePseudoClass: #active.
		pushedItem refresh.
		pushedItem := nil].
]
