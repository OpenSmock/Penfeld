Class {
	#name : #PenBlocRadioGroupDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocRadioGroupDresser >> initInteractor [
	self model interactor: BlElement new.
	self model interactor layout: BlLinearLayout vertical.
	self model interactor constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self model radioButtons do: [ :each |
		self model interactor addChild: each interactor ]
]
