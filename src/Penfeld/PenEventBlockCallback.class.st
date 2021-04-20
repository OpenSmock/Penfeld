Class {
	#name : #PenEventBlockCallback,
	#superclass : #PenEventCallback,
	#instVars : [
		'block'
	],
	#category : #'Penfeld-Events'
}

{ #category : #accessing }
PenEventBlockCallback >> block [
	^ block
]

{ #category : #accessing }
PenEventBlockCallback >> block: anObject [
	block := anObject
]

{ #category : #private }
PenEventBlockCallback >> executeCallback [
	self block value
]

{ #category : #private }
PenEventBlockCallback >> executeCallback: anEvent [
	self block cull: anEvent
]
