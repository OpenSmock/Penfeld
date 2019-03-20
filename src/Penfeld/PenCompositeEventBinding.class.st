Class {
	#name : #PenCompositeEventBinding,
	#superclass : #PenEventBinding,
	#instVars : [
		'symbols'
	],
	#category : #'Penfeld-Events'
}

{ #category : #testing }
PenCompositeEventBinding >> isCompositeEvent [
	^ true
]

{ #category : #accessing }
PenCompositeEventBinding >> symbols [
	^ symbols
]

{ #category : #accessing }
PenCompositeEventBinding >> symbols: aList [
	symbols := aList
]
