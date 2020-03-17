Class {
	#name : #PenBlocTreeTableDresser,
	#superclass : #PenBlocDresser,
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
	listElements := self component getExpandedNodesAsList collect: [ :item | 
		i = 0 
			ifTrue: [ i := 1 ]
			ifFalse: [ i := 0. item refresh].
		item engineElement ].
	self component showHeader ifTrue: 
		[ listElements addFirst: self component header engineElement ].
	dataSource elements: listElements.
	self component engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeTableDresser >> initEngineElement [
	self component engineElement: PenInfiniteListElement new.
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	self component engineElement dataSource: dataSource.
]
