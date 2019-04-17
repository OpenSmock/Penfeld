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
	self model engineElement background: aValue
]

{ #category : #dressing }
PenBlocTreeDresser >> doBeforeApplyStyle [
	| listElements |
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		item engineElement ].
	dataSource elements: listElements.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTreeDresser >> initEngineElement [
	self model engineElement: PenInfiniteListElement new.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PenInfiniteDataSource new.
	self model engineElement dataSource: dataSource.
]
