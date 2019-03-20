Class {
	#name : #PenBlocTableDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocTableDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
PenBlocTableDresser >> border: aValue [
	| borderBuilder |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	self model engineElement border: borderBuilder build.
]

{ #category : #dressing }
PenBlocTableDresser >> doBeforeApplyStyle [
	| listElements |
	listElements := self model items collect: [ :item | 
		item engineElement ].
	listElements addFirst: self model header engineElement.
	dataSource elements: listElements.
	self model engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTableDresser >> initEngineElement [
	dataSource := PenInfiniteDataSource new.
	
	self model engineElement: PenInfiniteListElement new.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self model allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self model items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
]

{ #category : #events }
PenBlocTableDresser >> whenMouseDownEventOn: anItem [ 
	anItem refreshStyle.
	pushedItem := anItem.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem refreshStyle.
	pushedItem := nil.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem refreshStyle.
		pushedItem := nil].
]
