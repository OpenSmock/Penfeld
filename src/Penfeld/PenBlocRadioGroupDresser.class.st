Class {
	#name : #PenBlocRadioGroupDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocRadioGroupDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout vertical.
	self model engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self model radioButtons do: [ :each |
		self model engineElement addChild: each engineElement ]
]
