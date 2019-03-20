Class {
	#name : #PenDBlocScrollBar,
	#superclass : #PenBlocDresser,
	#instVars : [
		'extent'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenDBlocScrollBar >> applyButtonStyle: aStyle [
	| button1 button2 background border |
	button1 := self model interactor childNamed: #button1.
	button2 := self model interactor childNamed: #button2.
	background := self getBackground: aStyle.
	background ifNotNil: [ 
		button1 background: background.
		button2 background: background. ].
	border := self getBorder: aStyle.
	border ifNotNil: [ 
		button1 border: border.
		button2 border: border. ].
	
]

{ #category : #dressing }
PenDBlocScrollBar >> applyStyleSheet [
	| styles selectors |
	super applyStyleSheet.
	selectors := OrderedCollection new.
	selectors add: #body.
	selectors add: #button.
	styles := self model stylesheet stylesFor: selectors.
	styles do: [ :style | self applyButtonStyle: style ]
]

{ #category : #initialization }
PenDBlocScrollBar >> initBar [
	| bar |
	bar := self model interactor childNamed: #bar.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #initialization }
PenDBlocScrollBar >> initButtons [
	| button |
	button := self model interactor childNamed: #button1.
	button layout: BlFrameLayout new.
	button constraintsDo: [ :c |
		c horizontal exact: 20.
		c vertical exact: 20 ].
	
	button := self model interactor childNamed: #button2.
	button layout: BlFrameLayout new.
	button constraintsDo: [ :c |
		c horizontal exact: 20.
		c vertical exact: 20 ].
	
]

{ #category : #initialization }
PenDBlocScrollBar >> initInteractor [
	self model interactor: BlElement new.
	self model isHorizontal
		ifTrue: [ 
			self model interactor layout: BlLinearLayout horizontal.
			self model constraintsDo: [ :c | 
				c horizontal exact: self model size.
				c vertical fitContent. ] ]
		ifFalse: [ self model interactor layout: BlLinearLayout vertical.
			self model constraintsDo: [ :c | 
				c horizontal fitContent. 
				c vertical exact: self model size.]  ].
	
	self model addChild: BlElement new as: #button1.
	self model addChild: BlElement new as: #button2.
	self model addChild: BlElement new as: #bar.
	
	self initButtons.
	self initBar
]
