Class {
	#name : #PenBlocTableItemDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocSizeStyle + TPenBlocBackgroundStyle + TPenBlocBorderStyle + TPenBlocMarginStyle',
	#classTraits : 'TPenBlocSizeStyle classTrait + TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait + TPenBlocMarginStyle classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTableItemDresser >> doAfterApplyStyle [ 
	self component parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self component atSection: selector.
		content engineElement constraintsDo: [ :c | 
			fixedSize isNumber ifTrue: [ c horizontal exact: fixedSize ].
			fixedSize = #maximized ifTrue: [ c horizontal matchParent ]
		].
	].
]

{ #category : #'accessing structure variables' }
PenBlocTableItemDresser >> height: aValue [
	self component engineElement constraintsDo: [ :c |
		c vertical exact: aValue ].
	self component content do: [ :element |
		element height: aValue.
		element refresh ]
]

{ #category : #dressing }
PenBlocTableItemDresser >> initEngineElement [
	self component engineElement: BlElement new.
	self component engineElement layout: BlLinearLayout horizontal.
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
	].
	
	self component parent sections do: [ :section | 
		| selector content |
		selector := section selector.
		content := self component atSection: selector.
		self component engineElement addChild: content engineElement as: selector
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
