Class {
	#name : #PenEventFunctionCallback,
	#superclass : #PenEventCallback,
	#instVars : [
		'performer',
		'function'
	],
	#category : #'Penfeld-Events'
}

{ #category : #private }
PenEventFunctionCallback >> executeCallback [
	self performer perform: self function 
]

{ #category : #private }
PenEventFunctionCallback >> executeCallback: anEvent [
	self performer perform: self function with: anEvent
]

{ #category : #accessing }
PenEventFunctionCallback >> function [
	^ function
]

{ #category : #accessing }
PenEventFunctionCallback >> function: anObject [
	function := anObject
]

{ #category : #accessing }
PenEventFunctionCallback >> performer [
	^ performer
]

{ #category : #accessing }
PenEventFunctionCallback >> performer: anObject [
	performer := anObject
]
