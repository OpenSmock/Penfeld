Class {
	#name : #PenBlocTreeTableDresser,
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
PenBlocTreeTableDresser >> doBeforeApplyStyle [
	| listElements i |
	i := 0.
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		i = 0 
			ifTrue: [ i := 1 ]
			ifFalse: [ i := 0. item refresh].
		item engineElement ].
	self model showHeader ifTrue: 
		[ listElements addFirst: self model header engineElement ].
	dataSource elements: listElements.
	self model engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeTableDresser >> initEngineElement [
	self model engineElement: PenInfiniteListElement new.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	self model engineElement dataSource: dataSource.
]

{ #category : #events }
PenBlocTreeTableDresser >> whenMouseDownEventOn: anItem [ 
	anItem activatePseudoClass: #active.
	anItem refresh.
	pushedItem := anItem.
]

{ #category : #events }
PenBlocTreeTableDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem deactivatePseudoClass: #active.
	anItem refresh.
	pushedItem := nil.
]

{ #category : #events }
PenBlocTreeTableDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem deactivatePseudoClass: #active.
		pushedItem refresh.
		pushedItem := nil].
]
