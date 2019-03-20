Class {
	#name : #PenDBlocTree,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTree class >> styleSelector [
	^ #tree
]

{ #category : #dressing }
PenDBlocTree >> applyStyle: aStyle [
	| background |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model engineElement background: background ].
]

{ #category : #dressing }
PenDBlocTree >> doBeforeApplyStyle [
	| listElements |
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		item engineElement ].
	dataSource elements: listElements.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTree >> initEngineElement [
	self model engineElement: PFInfiniteListElement new.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PFInfiniteDataSource new.
	self model engineElement dataSource: dataSource.
]
