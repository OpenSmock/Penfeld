Class {
	#name : #PenBlocCheckBoxDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'ropedText',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocCheckBoxDresser >> background: aModel on: aComponent [
	self background: aModel onBl: (aComponent engineElement childNamed: #box).
	
]

{ #category : #styling }
PenBlocCheckBoxDresser >> border: aModel on: aComponent [
	self border: aModel onBl: (aComponent engineElement childNamed: #box).
	
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> doBeforeApplyStyleOn: aComponent [
	(aComponent engineElement childNamed: #mark) visibility: (aComponent value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).

	(aComponent engineElement childNamed: #text) text: aComponent text asRopedText
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> initEngineElementFor: aComponent [
	| box check |
	
	aComponent engineElement: BlElement new.
	aComponent isLabelAfter
		ifTrue: [ aComponent engineElement layout: BlLinearLayout horizontal leftToRight ]
		ifFalse: [ aComponent engineElement layout: BlLinearLayout horizontal rightToLeft ].
	aComponent engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	check := BlElement new.
	check geometry: (BlPolyline vertices: {2@6. 4@10. 10@3}). self flag: #moveInStyle.
	
	box := BlElement new.
	box addChild: check as: #mark.
	box size: 14 @ 14. self flag: #moveInStyle.
	
	aComponent engineElement addChild: box as: #box.
	aComponent engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	aComponent engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: aComponent ].
	aComponent engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: aComponent ].
	aComponent engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: aComponent ].
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseDownEventOn: aComponent [
	aComponent activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseLeaveEventOn: aComponent [
	pushed := false.
	aComponent deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseUpEventOn: aComponent [
	pushed ifFalse: [^ self].
	aComponent deactivatePseudoClass: #active.
	pushed := false.
]
