Class {
	#name : #PenEventStrategy,
	#superclass : #Object,
	#category : #'Penfeld-Events'
}

{ #category : #binding }
PenEventStrategy class >> bindAction: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy class >> bindClick: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy class >> bindMouseDown: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
PenEventStrategy class >> new [
	^ self shouldNotImplement 
]

{ #category : #binding }
PenEventStrategy class >> tryToBind: anEventBinding [
	| symbol |
	
	anEventBinding isCompositeEvent ifTrue: [ 
		"self traceCr: 'Can not bind composite binding.'."
		^ false ].
	
	symbol := anEventBinding symbol.
	symbol = PenEventSymbol click
		ifTrue: [ ^ self bindClick: anEventBinding ]
		ifFalse: 
	[ symbol = PenEventSymbol action
		ifTrue: [ ^ self bindAction: anEventBinding ]
		ifFalse: [ "self traceCr: self printString, ' can not bind ', symbol." ^ false]]
]
