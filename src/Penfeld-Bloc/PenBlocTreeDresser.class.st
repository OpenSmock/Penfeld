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
PenBlocTreeDresser >> doAfterApplyStyle [ 
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
