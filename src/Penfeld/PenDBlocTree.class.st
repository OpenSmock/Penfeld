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
	background ifNotNil: [ self model interactor background: background ].
]

{ #category : #dressing }
PenDBlocTree >> doBeforeApplyStyle [
	| listElements |
	listElements := self model getExpandedNodesAsList collect: [ :item | 
		item interactor ].
	dataSource elements: listElements.
	dataSource notifyChanged
]

{ #category : #initialization }
PenDBlocTree >> initInteractor [
	self model interactor: PFInfiniteListElement new.
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	dataSource := PFInfiniteDataSource new.
	self model interactor dataSource: dataSource.
]
