Class {
	#name : #PenBlocTableDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait',
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTableDresser >> addComponent: anElement [
	dataSource addElement: anElement engineElement.
]

{ #category : #dressing }
PenBlocTableDresser >> doAfterApplyStyle [ 
	| var element |
	element := self component engineElement.

	"Position"
	var := self component position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ element width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ element height: var pref ].
]

{ #category : #dressing }
PenBlocTableDresser >> doBeforeApplyStyle [
]

{ #category : #dressing }
PenBlocTableDresser >> initEngineElement [
	| listElements |
	dataSource := PenInfiniteDataSource new.
	
	self component engineElement: PenInfiniteListElement new.
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	listElements := self component items collect: [ :item | 
		item engineElement ].
	self component header ifNotNil: [ 
		listElements addFirst: self component header engineElement
	].
	dataSource elements: listElements.
	self component engineElement dataSource: dataSource.
	
	self component allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self component items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
]

{ #category : #dressing }
PenBlocTableDresser >> removeComponent: anElement [
	dataSource removeElement: anElement engineElement.
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
