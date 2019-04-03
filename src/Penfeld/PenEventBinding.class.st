Class {
	#name : #PenEventBinding,
	#superclass : #Object,
	#traits : 'TPenDebug',
	#classTraits : 'TPenDebug classTrait',
	#instVars : [
		'source',
		'callback'
	],
	#category : #'Penfeld-Events'
}

{ #category : #factory }
PenEventBinding class >> for: aSymbol do: aBlock [
	^ PenSimpleEventBinding new
		symbol: aSymbol;
		callback: (PenEventBlockCallback new block: aBlock);
		yourself
]

{ #category : #factory }
PenEventBinding class >> for: aSymbol perform: aFunction on: aPerformer [
	^ PenSimpleEventBinding new
		symbol: aSymbol;
		callback: (PenEventFunctionCallback new
			function: aFunction;
			performer: aPerformer);
		yourself
]

{ #category : #factory }
PenEventBinding class >> forAll: aList do: aBlock [
	^ PenCompositeEventBinding new
		symbols: aList;
		callback: aBlock;
		yourself
]

{ #category : #factory }
PenEventBinding class >> forAll: aList perform: aFunction on: aPerformer [
	^ PenCompositeEventBinding new
		symbols: aList;
		callback: (PenEventFunctionCallback new
			function: aFunction;
			performer: aPerformer);
		yourself
]

{ #category : #accessing }
PenEventBinding >> callback [
	^ callback
]

{ #category : #accessing }
PenEventBinding >> callback: aBlock [
	callback := aBlock
]

{ #category : #accessing }
PenEventBinding >> executeCallback [
	self source isDisabled ifTrue: [ ^ self ].
	self callback executeCallback.
]

{ #category : #accessing }
PenEventBinding >> executeCallback: anEvent [
	self source isDisabled ifTrue: [ ^ self ].
	self callback executeCallback: anEvent.
]

{ #category : #testing }
PenEventBinding >> isCompositeEvent [
	^ false
]

{ #category : #testing }
PenEventBinding >> isSimpleEvent [
	^ false
]

{ #category : #accessing }
PenEventBinding >> source [
	^ source
]

{ #category : #accessing }
PenEventBinding >> source: anObject [
	source := anObject
]

{ #category : #testing }
PenEventBinding >> symbolMatches: aSymbol [
	self subclassResponsibility 
]
