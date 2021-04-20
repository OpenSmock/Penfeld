Class {
	#name : #PenBlocTreeDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTreeDresser >> doBeforeApplyStyleOn: aComponent [
	| listElements |
	listElements := aComponent getExpandedNodesAsList collect: [ :item | 
		item engineElement ].
	dataSource elements: listElements.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeDresser >> initEngineElementFor: aComponent [
	aComponent engineElement: PenInfiniteListElement new.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	aComponent engineElement dataSource: dataSource.
]
