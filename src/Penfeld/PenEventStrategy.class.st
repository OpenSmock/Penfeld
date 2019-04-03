Class {
	#name : #PenEventStrategy,
	#superclass : #Object,
	#traits : 'TPenDebug',
	#classTraits : 'TPenDebug classTrait',
	#category : #'Penfeld-Events'
}

{ #category : #binding }
PenEventStrategy >> tryToBind: anEventBinding [
	| symbol |
	
	anEventBinding isCompositeEvent ifTrue: [ 
		self warn: 'Can not install composite binding.'.
		^ false ].
	
	symbol := anEventBinding symbol.
	symbol = PenEventSymbol click
		ifTrue: [ ^ self tryToBindClickOn: anEventBinding source ]
		ifFalse: 
	[ symbol = PenEventSymbol action
		ifTrue: [ ^ self tryToBindActionOn: anEventBinding source  ]
		ifFalse: [ self warn: self printString, ' can not bind ', symbol. ^ false]]
]

{ #category : #binding }
PenEventStrategy >> tryToBindActionOn: aComponent [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy >> tryToBindClickOn: aComponent [
	^ self subclassResponsibility 
]

{ #category : #binding }
PenEventStrategy >> tryToBindMouseDownOn: aComponent [
	^ self subclassResponsibility 
]
