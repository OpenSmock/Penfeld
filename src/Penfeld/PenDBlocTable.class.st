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
	background ifNotNil: [ self model interactor background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ self model interactor border: border ].
]

{ #category : #dressing }
PenDBlocTable >> doBeforeApplyStyle [
	| listElements |
	listElements := self model items collect: [ :item | 
		item interactor ].
	listElements addFirst: self model header interactor.
	dataSource elements: listElements.
	self model interactor dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTable >> initInteractor [
	dataSource := PFInfiniteDataSource new.
	
	self model interactor: PFInfiniteListElement new.
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self model allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self model items do: [ :item |
		item interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
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
