Class {
	#name : #PenBlocScrollBarDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'extent'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #initialization }
PenBlocScrollBarDresser >> initBar [
	| bar |
	bar := self model engineElement childNamed: #bar.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #initialization }
PenBlocScrollBarDresser >> initButtons [
	| button |
	button := self model engineElement childNamed: #button1.
	button layout: BlFrameLayout new.
	button constraintsDo: [ :c |
		c horizontal exact: 20.
		c vertical exact: 20 ].
	
	button := self model engineElement childNamed: #button2.
	button layout: BlFrameLayout new.
	button constraintsDo: [ :c |
		c horizontal exact: 20.
		c vertical exact: 20 ].
	
]

{ #category : #initialization }
PenBlocScrollBarDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model isHorizontal
		ifTrue: [ 
			self model engineElement layout: BlLinearLayout horizontal.
			self model constraintsDo: [ :c | 
				c horizontal exact: self model size.
				c vertical fitContent. ] ]
		ifFalse: [ self model engineElement layout: BlLinearLayout vertical.
			self model constraintsDo: [ :c | 
				c horizontal fitContent. 
				c vertical exact: self model size.]  ].
	
	self model addChild: BlElement new as: #button1.
	self model addChild: BlElement new as: #button2.
	self model addChild: BlElement new as: #bar.
	
	self initButtons.
	self initBar
]
