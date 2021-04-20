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
PenBlocTreeTableDresser >> doBeforeApplyStyleOn: aComponent [
	| listElements i |
	i := 0.
	listElements := aComponent getExpandedNodesAsList collect: [ :item | 
		i = 0 
			ifTrue: [ i := 1 ]
			ifFalse: [ i := 0. item refresh].
		item engineElement ].
	aComponent showHeader ifTrue: 
		[ listElements addFirst: aComponent header engineElement ].
	dataSource elements: listElements.
	aComponent engineElement dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeTableDresser >> initEngineElementFor: aComponent [
	aComponent engineElement: PenInfiniteListElement new.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	aComponent engineElement dataSource: dataSource.
]
