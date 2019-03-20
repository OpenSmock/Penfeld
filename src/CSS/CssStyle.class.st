Class {
	#name : #CssStyle,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declaration',
		'conditions',
		'ordinal'
	],
	#category : #'CSS-Utils'
}

{ #category : #comparing }
CssStyle >> < aStyle [
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)
]

{ #category : #comparing }
CssStyle >> <= aStyle [
	^ ((self compareTo: aStyle) = 1) not
]

{ #category : #comparing }
CssStyle >> = aStyle [
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]
]

{ #category : #comparing }
CssStyle >> > aStyle [
	^ (self compareTo: aStyle) = 1 or: (self specificity = aStyle specificity and: self ordinal > aStyle ordinal)
]

{ #category : #comparing }
CssStyle >> >= aStyle [
	^ (self compareTo: aStyle) != -1
]

{ #category : #comparing }
CssStyle >> compareTo: aStyle [
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
CssStyle >> conditions [
	^ conditions
]

{ #category : #accessing }
CssStyle >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
CssStyle >> declaration [
	^ declaration
]

{ #category : #accessing }
CssStyle >> declaration: anObject [
	declaration := anObject
]

{ #category : #testing }
CssStyle >> isImportant [
	^ declaration isImportant
]

{ #category : #testing }
CssStyle >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
]

{ #category : #accessing }
CssStyle >> ordinal [
	^ ordinal
]

{ #category : #accessing }
CssStyle >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
CssStyle >> origin [
	^ selector origin
]

{ #category : #printing }
CssStyle >> printOn: aStream [
	self declaration printOn: aStream
]

{ #category : #accessing }
CssStyle >> selector [
	^ selector
]

{ #category : #accessing }
CssStyle >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
CssStyle >> specificity [
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
]
