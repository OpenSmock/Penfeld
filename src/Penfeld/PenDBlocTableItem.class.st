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
	background ifNotNil: [ self model interactor background: background ].
]

{ #category : #initialization }
PenDBlocTableItem >> initInteractor [
	self model interactor: BlElement new.
	self model interactor layout: BlLinearLayout horizontal.
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	self model parent sections do: [ :section | 
		| selector item fixedSize |
		selector := section selector.
		fixedSize := section size.
		item := self model contentAtSection: selector.
		fixedSize ifNotNil: [ item interactor constraintsDo: [ :c | c horizontal exact: fixedSize ]].
		self model interactor addChild: item interactor as: selector].
]

{ #category : #dressing }
PenDBlocTableItem >> sectionsOrderChanged: aModel [
	| temp |
	temp := Dictionary new.
	aModel parent sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aModel interactor childNamed: selector).
		aModel interactor removeChildNamed: selector ].
	aModel parent sections do: [ :section |
		aModel interactor addChild: (temp at: section selector) ]
]
