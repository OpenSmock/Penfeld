Class {
	#name : #PenBlocRadioButtonDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'pushed',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocRadioButtonDresser >> background: aModel on: aComponent [
	self background: aModel onBl: (aComponent engineElement childNamed: #box).
	
]

{ #category : #styling }
PenBlocRadioButtonDresser >> border: aModel on: aComponent [
	self border: aModel onBl: (aComponent engineElement childNamed: #box).
	
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> doBeforeApplyStyleOn: aComponent [
	(aComponent engineElement childNamed: #mark) visibility: (aComponent value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).

	(aComponent engineElement childNamed: #text) text: aComponent text asRopedText
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> initEngineElementFor: aComponent [
	| box check layout |
	
	aComponent engineElement: BlElement new.
	aComponent isLabelAfter
		ifTrue: [ 
			layout := BlLinearLayout horizontal leftToRight.
			layout alignTopLeft.
		]
		ifFalse: [ 
			layout := BlLinearLayout horizontal rightToLeft.
			layout alignTopRight.
		].
	aComponent engineElement layout: layout.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	check := BlElement new.
	check geometry: BlEllipse new.
	check size: 6@6. 
	check constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	
	box := BlElement new.
	box layout: BlFrameLayout new.
	box addChild: check as: #mark.
	box geometry: BlEllipse new.
	box size: 12@12.
	
	aComponent engineElement addChild: box as: #box.
	aComponent engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	aComponent engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: aComponent ].
	aComponent engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: aComponent ].
	aComponent engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: aComponent ].
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseDownEventOn: aComponent [
	aComponent activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseLeaveEventOn: aComponent [
	pushed := false.
	aComponent deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseUpEventOn: aComponent [
	pushed ifFalse: [^ self].
	aComponent deactivatePseudoClass: #active.
	pushed := false.
]
