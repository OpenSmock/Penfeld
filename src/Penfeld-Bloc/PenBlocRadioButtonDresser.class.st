Class {
	#name : #PenBlocRadioButtonDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocMarginStyle',
	#classTraits : 'TPenBlocMarginStyle classTrait',
	#instVars : [
		'pushed',
		'pushedItem',
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocRadioButtonDresser >> backgroundColor: aValue [
	| box |
	box := self component engineElement childNamed: #box.
	box background: aValue
]

{ #category : #styling }
PenBlocRadioButtonDresser >> border: aValue [
	| borderBuilder |
	borderBuilder := BlBorderBuilder new.
	
	aValue do: 
	[ :property | 
		property value isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: [
			property value isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property value) 
				ifTrue: [ borderBuilder perform: property value ]
			]
			ifFalse: [ 
				(property value isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].

	(self component engineElement childNamed: #box) border: borderBuilder build.
	(self component engineElement childNamed: #check) background: borderBuilder paint.
]

{ #category : #styling }
PenBlocRadioButtonDresser >> color: aValue [
	| textElement |
	textElement := self component engineElement childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement text foreground: aValue
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement height: var pref ].
	
	"Apply roped text"
	self component engineElement childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> doBeforeApplyStyle [ 
	(self component engineElement childNamed: #check) visibility: (self component value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).
		
	ropedText := self component text asRopedText

]

{ #category : #styling }
PenBlocRadioButtonDresser >> fontFamily: aValue [
	ropedText fontName: aValue first.
]

{ #category : #styling }
PenBlocRadioButtonDresser >> fontSize: aValue [
	| size box check |
	size := aValue value.

	ropedText fontSize: size.
	
	box := self component engineElement childNamed: #box.
	box geometry: (BlEllipse diameter: size - 3).
	box size: (size - 3) asPoint.
	
	check := box childNamed: #check.
	check geometry: (BlEllipse diameter: size - 10).
	check size: (size - 10) asPoint. 
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> initEngineElement [
	| box check layout |
	
	self component engineElement: BlElement new.
	self component isLabelAfter
		ifTrue: [ 
			layout := BlLinearLayout horizontal leftToRight.
			layout alignTopLeft.
		]
		ifFalse: [ 
			layout := BlLinearLayout horizontal rightToLeft.
			layout alignTopRight.
		].
	self component engineElement layout: layout.
	self component engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	check := BlElement new.
	check geometry: (BlEllipse diameter: 5).
	check size: 6@6. 
	check constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	
	box := BlElement new.
	box layout: BlFrameLayout new.
	box addChild: check as: #check.
	box geometry: (BlEllipse diameter: 12).
	box size: 12@12.
	
	self component engineElement addChild: box as: #box.
	self component engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	self component engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self component engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self component engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseDownEvent [
	self component activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseLeaveEvent [
	pushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseUpEvent [
	pushed ifFalse: [^ self].
	self component deactivatePseudoClass: #active.
	pushed := false.
]
