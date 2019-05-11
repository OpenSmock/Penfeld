Class {
	#name : #PenBlocTreeDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocTreeDresser >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #dressing }
PenBlocTreeDresser >> doBeforeApplyStyle [
	| listElements |
	listElements := self component getExpandedNodesAsList collect: [ :item | 
		item engineElement ].
	dataSource elements: listElements.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeDresser >> initEngineElement [
	self component engineElement: PenInfiniteListElement new.
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	self component engineElement dataSource: dataSource.
]
