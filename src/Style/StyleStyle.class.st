Class {
	#name : #StyleStyle,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declaration',
		'conditions',
		'ordinal'
	],
	#category : #'Style-Utils'
}

{ #category : #comparing }
StyleStyle >> < aStyle [
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)
]

{ #category : #comparing }
StyleStyle >> <= aStyle [
	^ ((self compareTo: aStyle) = 1) not
]

{ #category : #comparing }
StyleStyle >> = aStyle [
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]
]

{ #category : #comparing }
StyleStyle >> > aStyle [
	^ (self compareTo: aStyle) = 1 or: (self specificity = aStyle specificity and: self ordinal > aStyle ordinal)
]

{ #category : #comparing }
StyleStyle >> >= aStyle [
	^ (self compareTo: aStyle) != -1
]

{ #category : #comparing }
StyleStyle >> compareTo: aStyle [
	self isImportant = aStyle isImportant
		ifFalse: [ ^ self isImportant
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self origin = aStyle origin
		ifFalse:
			[ ^ (self origin priority >= aStyle origin priority and: [ self specificity >= aStyle specificity ])
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self specificity = aStyle specificity
		ifFalse: [ ^ self specificity >= aStyle specificity
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	^ 0
]

{ #category : #accessing }
StyleStyle >> conditions [
	^ conditions
]

{ #category : #accessing }
StyleStyle >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
StyleStyle >> declaration [
	^ declaration
]

{ #category : #accessing }
StyleStyle >> declaration: anObject [
	declaration := anObject
]

{ #category : #testing }
StyleStyle >> isImportant [
	^ declaration isImportant
]

{ #category : #testing }
StyleStyle >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
]

{ #category : #accessing }
StyleStyle >> ordinal [
	^ ordinal
]

{ #category : #accessing }
StyleStyle >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
StyleStyle >> origin [
	^ selector origin
]

{ #category : #printing }
StyleStyle >> printOn: aStream [
	self declaration printOn: aStream
]

{ #category : #accessing }
StyleStyle >> selector [
	^ selector
]

{ #category : #accessing }
StyleStyle >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
StyleStyle >> specificity [
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
]
