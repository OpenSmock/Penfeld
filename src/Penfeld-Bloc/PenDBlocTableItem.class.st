Class {
	#name : #PenDBlocTableItem,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTableItem class >> styleSelector [
	^ #tr
]

{ #category : #dressing }
PenDBlocTableItem >> applyStyle: aStyle [
	| background |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model engineElement background: background ].
]

{ #category : #initialization }
PenDBlocTableItem >> initEngineElement [
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

{ #category : #dressing }
PenDBlocTableItem >> sectionsOrderChanged: aModel [
	| temp |
	temp := Dictionary new.
	aModel parent sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aModel engineElement childNamed: selector).
		aModel engineElement removeChildNamed: selector ].
	aModel parent sections do: [ :section |
		aModel engineElement addChild: (temp at: section selector) ]
]
