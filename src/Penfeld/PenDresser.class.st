Class {
	#name : #PenDresser,
	#superclass : #Object,
	#instVars : [
		'styleSelector'
	],
	#category : #'Penfeld-Abstracts'
}

{ #category : #accessing }
PenDresser class >> systemIcon [ 
	^ self iconNamed: #paint
]

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

{ #category : #dressing }
PenDresser >> applyStyle: aDeclaration on: aComponent [
	| mutator |
	mutator := aDeclaration property asMutator, #on:.
	(self respondsTo: mutator)
		ifTrue: [ self perform: mutator with: aDeclaration model with: aComponent ]
		ifFalse: [ self notYetImplemented ]
]

{ #category : #styling }
PenDresser >> background: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> backgroundColor: aValue [
]

{ #category : #styling }
PenDresser >> backgroundImage: aValue [
]

{ #category : #styling }
PenDresser >> backgroundPosition: aValue [
]

{ #category : #styling }
PenDresser >> border: aValue [
]

{ #category : #styling }
PenDresser >> border: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> borderLeft: aStyle [
]

{ #category : #styling }
PenDresser >> borderRadius: aValue [
]

{ #category : #styling }
PenDresser >> borderRadius: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> color: aValue [
]

{ #category : #accessing }
PenDresser >> component [ 
	^ component
]

{ #category : #accessing }
PenDresser >> component: aComponent [
	component := aComponent
]

{ #category : #dressing }
PenDresser >> doAfterApplyStyle [
]

{ #category : #dressing }
PenDresser >> doAfterApplyStyleOn: aComponent [
]

{ #category : #dressing }
PenDresser >> doBeforeApplyStyle [
]

{ #category : #dressing }
PenDresser >> doBeforeApplyStyleOn: aComponent [
]

{ #category : #dressing }
PenDresser >> dress [
	self component isVisible 
		ifTrue: [ 
			self show.
			self doBeforeApplyStyle.
			self component matchedRules do: [ :rule | self applyStyle: rule ].
			self doAfterApplyStyle.
		]
		ifFalse: [ self hide ]
]

{ #category : #dressing }
PenDresser >> dress: aComponent [
	aComponent isVisible 
		ifTrue: [ 
			self show: aComponent.
			self doBeforeApplyStyleOn: aComponent.
			aComponent style do: [ :decl | self applyStyle: decl on: aComponent].
			self doAfterApplyStyleOn: aComponent.
		]
		ifFalse: [ self hide: aComponent ]
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
PenDresser >> font: aModel on: aComponent [
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
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
	arg isFunction ifTrue: [ ^ self performFunction: arg ].
	^ arg
]

{ #category : #styling }
PenDresser >> height: aValue [
]

{ #category : #styling }
PenDresser >> height: aModel on: aComponent [
]

{ #category : #helpers }
PenDresser >> helperIcon: args [
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
]

{ #category : #helpers }
PenDresser >> helperLinearGradient: args [
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
]

{ #category : #helpers }
PenDresser >> helperRgb: args [
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
]

{ #category : #helpers }
PenDresser >> helperRgba: args [
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
]

{ #category : #dressing }
PenDresser >> hide [ 
	^ self subclassResponsibility
]

{ #category : #dressing }
PenDresser >> hide: aComponent [
	^ self subclassResponsibility
]

{ #category : #dressing }
PenDresser >> initEngineElement [
	^ self subclassResponsibility
]

{ #category : #dressing }
PenDresser >> initEngineElementFor: aComponent [
	^ self subclassResponsibility
]

{ #category : #styling }
PenDresser >> margin: aValue [
]

{ #category : #styling }
PenDresser >> margin: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> maxHeight: aValue [
]

{ #category : #styling }
PenDresser >> maxWidth: aValue [
]

{ #category : #styling }
PenDresser >> outline: aModel on: anElement [
]

{ #category : #styling }
PenDresser >> padding: aValue [
]

{ #category : #styling }
PenDresser >> padding: aModel on: aComponent [
]

{ #category : #'*Penfeld-Experimental' }
PenDresser >> penLoader: aValue [
]

{ #category : #dressing }
PenDresser >> performFunction: aFunction [
	self deprecated: 'Not used anymore: PharoStylesheet-Model has replaced it'.
	^ self 
		perform: ('helper' , aFunction asCamelCase) asSymbol asMutator 
		with: aFunction args 
]

{ #category : #styling }
PenDresser >> position: aModel on: aComponent [
]

{ #category : #dressing }
PenDresser >> show [ 
	^ self subclassResponsibility
]

{ #category : #dressing }
PenDresser >> show: aComponent [
	^ self subclassResponsibility
]

{ #category : #styling }
PenDresser >> text: aModel on: aComponent [
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

{ #category : #styling }
PenDresser >> width: aModel on: aComponent [
]
