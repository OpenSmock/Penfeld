Class {
	#name : #PenBlocTableItemDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocSizeStyle + TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocSizeStyle classTrait + TPenBlocBackgroundStyle classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTableItemDresser >> doBeforeApplyStyle [ 
	self component parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self component atSection: selector.
		fixedSize ifNotNil: [ 
			content engineElement constraintsDo: [ :c | 
				c horizontal exact: fixedSize ]
			].
		].
]

{ #category : #dressing }
PenBlocTableItemDresser >> initEngineElement [
	self component engineElement: BlElement new.
	self component engineElement layout: BlLinearLayout horizontal.
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		self flag: 'ideally: c vertical fitContent'.
		c vertical exact: 20.
	].
	
	self component parent sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self component atSection: selector.
		fixedSize ifNotNil: [ content engineElement constraintsDo: [ :c | c horizontal exact: fixedSize ]].
		self component engineElement addChild: content engineElement as: selector].
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
