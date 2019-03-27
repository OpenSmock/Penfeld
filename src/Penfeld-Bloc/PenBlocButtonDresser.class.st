Class {
	#name : #PenBlocButtonDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle + TPenBlocFontStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait + TPenBlocFontStyle classTrait + TPenBlocBorderStyle classTrait',
	#instVars : [
		'ropedText',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #rendering }
PenBlocButtonDresser >> doAfterApplyStyle [ 
	| var element |
	element := self model engineElement.

	"Position"
	var := self model position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ element width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ element height: var pref ].
	
	"Apply roped text"
	element childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
		
	self model isLoading 
		ifTrue: 
		[ 
			element childNamed: #loader
				ifFound: [ :anElement |  ]
				ifNone: [ element addChild: self loader as: #loader ]
		]
		ifFalse: [ element removeChildNamed: #loader ]
]

{ #category : #rendering }
PenBlocButtonDresser >> doBeforeApplyStyle [ 
	ropedText := self model text asRopedText
]

{ #category : #styling }
PenBlocButtonDresser >> height: aValue [
	self model engineElement height: aValue
]

{ #category : #dressing }
PenBlocButtonDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement layout: BlFrameLayout new.
	self model engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	self model engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self model engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self model engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #accessing }
PenBlocButtonDresser >> ropedText [
	^ ropedText
]

{ #category : #styling }
PenBlocButtonDresser >> textAlign: aValue [
	| textElement |
	textElement := self model engineElement childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement constraintsDo: [:c | 
		aValue = #center 
		ifTrue: [ 
			c frame horizontal alignCenter.
			c frame vertical alignCenter
		]
		ifFalse: [ self notYetImplemented  ] ].
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseDownEvent [
	self model isDisabled ifTrue: [ ^ self ].
	self model activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseLeaveEvent [
	self model isDisabled ifTrue: [ ^ self ].
	pushed := false.
	self model deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseUpEvent [
	self model isDisabled ifTrue: [ ^ self ].
	pushed ifFalse: [^ self].
	self model deactivatePseudoClass: #active.
	pushed := false.
]

{ #category : #styling }
PenBlocButtonDresser >> width: aValue [
	self model engineElement width: aValue
]
