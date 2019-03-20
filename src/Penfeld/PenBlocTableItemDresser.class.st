Class {
	#name : #PenBlocTableItemDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocTableItemDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #dressing }
PenBlocTableItemDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout horizontal.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	self model parent sections do: [ :section | 
		| selector item fixedSize |
		selector := section selector.
		fixedSize := section size.
		item := self model contentAtSection: selector.
		fixedSize ifNotNil: [ item engineElement constraintsDo: [ :c | c horizontal exact: fixedSize ]].
		self model engineElement addChild: item engineElement as: selector].
]

{ #category : #styling }
PenBlocTableItemDresser >> sectionsOrderChanged: aModel [
	| temp |
	temp := Dictionary new.
	aModel parent sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aModel engineElement childNamed: selector).
		aModel engineElement removeChildNamed: selector ].
	aModel parent sections do: [ :section |
		aModel engineElement addChild: (temp at: section selector) ]
]
