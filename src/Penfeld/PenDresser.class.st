Class {
	#name : #PenDresser,
	#superclass : #PenAbstractDresser,
	#instVars : [
		'styleSelector'
	],
	#category : #'Penfeld-Abstracts'
}

{ #category : #dressing }
PenDresser >> applyStyle: aRule [
	styleSelector := aRule selector.
	aRule declarations do: [ :declaration | | mutator value |
		mutator := declaration property asMutator.
		value := declaration value.
		value isFunction ifTrue: [ 
			value := self performFunction: value.
		].
		(self respondsTo: mutator)
			ifTrue: [ self perform: mutator with: value ]
			ifFalse: [ self notYetImplemented ]
	]
]

{ #category : #styling }
PenDresser >> backgroundColor: aValue [
]

{ #category : #styling }
PenDresser >> backgroundImage: aValue [
]

{ #category : #styling }
PenDresser >> border: aValue [
]

{ #category : #styling }
PenDresser >> borderLeft: aStyle [
]

{ #category : #styling }
PenDresser >> color: aValue [
]

{ #category : #dressing }
PenDresser >> doAfterApplyStyle [
]

{ #category : #dressing }
PenDresser >> doBeforeApplyStyle [
]

{ #category : #dressing }
PenDresser >> dress [
	self doBeforeApplyStyle.
	self component matchedRules do: [ :rule | self applyStyle: rule ].
	self doAfterApplyStyle.
]

{ #category : #accessing }
PenDresser >> dressersMap [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenDresser >> eventStrategy [ 
	^ self subclassResponsibility 
]

{ #category : #styling }
PenDresser >> fontFamily: aValue [
]

{ #category : #styling }
PenDresser >> fontSize: aValue [
]

{ #category : #styling }
PenDresser >> fontStyle: aValue [
]

{ #category : #styling }
PenDresser >> fontWeight: aValue [
]

{ #category : #private }
PenDresser >> getColor: arg [
	arg isFunction ifTrue: [ ^ self performFunction: arg ].
	^ arg
]

{ #category : #styling }
PenDresser >> height: aValue [
]

{ #category : #helpers }
PenDresser >> helperIcon: args [
]

{ #category : #helpers }
PenDresser >> helperLinearGradient: args [
]

{ #category : #helpers }
PenDresser >> helperRgb: args [
]

{ #category : #helpers }
PenDresser >> helperRgba: args [
]

{ #category : #dressing }
PenDresser >> initEngineElement [
	^ self subclassResponsibility
]

{ #category : #styling }
PenDresser >> margin: aValue [
]

{ #category : #styling }
PenDresser >> padding: aValue [
]

{ #category : #dressing }
PenDresser >> performFunction: aFunction [
	^ self 
		perform: ('helper' , aFunction asCamelCase) asSymbol asMutator 
		with: aFunction args 
]

{ #category : #styling }
PenDresser >> textAlign: aValue [
]

{ #category : #styling }
PenDresser >> verticalAlign: aValue [
]

{ #category : #styling }
PenDresser >> width: aValue [
]
