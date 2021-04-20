Class {
	#name : #PenBlocTableItemDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTableItemDresser >> doAfterApplyStyleOn: aComponent [
	aComponent parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := aComponent atSection: selector.
		content engineElement constraintsDo: [ :c | 
			fixedSize isNumber ifTrue: [ c horizontal exact: fixedSize ].
			fixedSize = #maximized ifTrue: [ c horizontal matchParent ]
		].
	].
]

{ #category : #dressing }
PenBlocTableItemDresser >> initEngineElementFor: aComponent [
	aComponent engineElement: BlElement new.
	aComponent engineElement layout: BlLinearLayout horizontal.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
	].
	
	aComponent parent sections do: [ :section | 
		| selector content |
		selector := section selector.
		content := aComponent atSection: selector.
		aComponent engineElement addChild: content engineElement as: selector
	].
]

{ #category : #styling }
PenBlocTableItemDresser >> sectionsOrderChanged: aComponent [
	| temp |
	temp := Dictionary new.
	aComponent parent sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aComponent engineElement childNamed: selector).
		aComponent engineElement removeChildNamed: selector ].
	aComponent parent sections do: [ :section |
		aComponent engineElement addChild: (temp at: section selector) ]
]
