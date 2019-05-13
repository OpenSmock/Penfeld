Class {
	#name : #PenEventStrategy,
	#superclass : #Object,
	#traits : 'TPenDebug',
	#classTraits : 'TPenDebug classTrait',
	#category : #'Penfeld-Events'
}

{ #category : #binding }
PenEventStrategy >> bindAction: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy >> bindClick: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy >> bindMouseDown: anEventBinding [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy >> tryToBind: anEventBinding [
	| symbol |
	
	anEventBinding isCompositeEvent ifTrue: [ 
		self warn: 'Can not bind composite binding.'.
		^ false ].
	
	symbol := anEventBinding symbol.
	symbol = PenEventSymbol click
		ifTrue: [ ^ self bindClick: anEventBinding ]
		ifFalse: 
	[ symbol = PenEventSymbol action
		ifTrue: [ ^ self bindAction: anEventBinding ]
		ifFalse: [ self warn: self printString, ' can not bind ', symbol. ^ false]]
]
