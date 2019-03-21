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
PenBlocTableItemDresser >> doBeforeApplyStyle [ 
	self model parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self model contentAtSection: selector.
		fixedSize ifNotNil: [ 
			content engineElement constraintsDo: [ :c | 
				c horizontal exact: fixedSize ]
			].
		].
]

{ #category : #dressing }
PenBlocTableItemDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout horizontal.
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 20. self flag: 'fitContent give 0 height because child matchParent ...' 
	].
	
	self model parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self model contentAtSection: selector.
		fixedSize ifNotNil: [ content engineElement constraintsDo: [ :c | c horizontal exact: fixedSize ]].
		self model engineElement addChild: content engineElement as: selector].
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
