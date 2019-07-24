Class {
	#name : #PenEventFunctionCallback,
	#superclass : #PenEventCallback,
	#instVars : [
		'receiver',
		'symbol'
	],
	#category : #'Penfeld-Events'
}

{ #category : #private }
PenEventFunctionCallback >> executeCallback [
	self receiver perform: self symbol 
]

{ #category : #private }
PenEventFunctionCallback >> executeCallback: anEvent [
	self receiver perform: self symbol with: anEvent
]

{ #category : #accessing }
PenEventFunctionCallback >> receiver [
	^ receiver
]

{ #category : #accessing }
PenEventFunctionCallback >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
PenEventFunctionCallback >> symbol [
	^ symbol
]

{ #category : #accessing }
PenEventFunctionCallback >> symbol: anObject [
	symbol := anObject
]
