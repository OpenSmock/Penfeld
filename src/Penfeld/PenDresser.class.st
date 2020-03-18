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
PenDresser >> border: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> borderRadius: aModel on: aComponent [
]

{ #category : #dressing }
PenDresser >> doAfterApplyStyleOn: aComponent [
]

{ #category : #dressing }
PenDresser >> doBeforeApplyStyleOn: aComponent [
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
PenDresser >> height: aModel on: aComponent [
]

{ #category : #dressing }
PenDresser >> hide: aComponent [
	^ self subclassResponsibility
]

{ #category : #dressing }
PenDresser >> initEngineElementFor: aComponent [
	^ self subclassResponsibility
]

{ #category : #styling }
PenDresser >> margin: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> outline: aModel on: anElement [
]

{ #category : #styling }
PenDresser >> padding: aModel on: aComponent [
]

{ #category : #'*Penfeld-Experimental' }
PenDresser >> penLoader: aValue [
]

{ #category : #styling }
PenDresser >> position: aModel on: aComponent [
]

{ #category : #dressing }
PenDresser >> show: aComponent [
	^ self subclassResponsibility
]

{ #category : #styling }
PenDresser >> text: aModel on: aComponent [
]

{ #category : #styling }
PenDresser >> width: aModel on: aComponent [
]
