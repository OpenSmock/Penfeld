Class {
	#name : #PenDBlocTable,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTable class >> styleSelector [
	^ #table
]

{ #category : #dressing }
PenDBlocTable >> applyStyle: aStyle [
	| background border |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model engineElement background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ self model engineElement border: border ].
]

{ #category : #dressing }
PenDBlocTable >> doBeforeApplyStyle [
	| listElements |
	listElements := self model items collect: [ :item | 
		item engineElement ].
	listElements addFirst: self model header engineElement.
	dataSource elements: listElements.
	self model engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTable >> initEngineElement [
	dataSource := PFInfiniteDataSource new.
	
	self model engineElement: PFInfiniteListElement new.
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
PenDBlocTable >> whenMouseDownEventOn: anItem [ 
	anItem resetStyles.
	pushedItem := anItem.
]

{ #category : #events }
PenDBlocTable >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem resetStyles.
	pushedItem := nil.
]

{ #category : #events }
PenDBlocTable >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem resetStyles.
		pushedItem := nil].
]
