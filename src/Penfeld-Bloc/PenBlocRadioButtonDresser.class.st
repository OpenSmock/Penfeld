Class {
	#name : #PenBlocRadioButtonDresser,
	#superclass : #PenBlocDresser,
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
	box := self model engineElement childNamed: #box.
	box background: aValue
]

{ #category : #styling }
PenBlocRadioButtonDresser >> border: aValue [
	| borderBuilder border paint |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ 
					paint := property. 
					borderBuilder paint: property
				]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].

	border := borderBuilder build.
	(self model engineElement childNamed: #box) border: border.
	(self model engineElement childNamed: #check) background: paint.
]

{ #category : #styling }
PenBlocRadioButtonDresser >> color: aValue [
	| textElement |
	textElement := self model engineElement childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement text foreground: aValue
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model engineElement width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model engineElement height: var pref ].
	
	"Apply roped text"
	self model engineElement childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> doBeforeApplyStyle [ 
	(self model engineElement childNamed: #check) visibility: (self model value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).
		
	ropedText := self model text asRopedText

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
	
	box := self model engineElement childNamed: #box.
	box geometry: (BlEllipse diameter: size - 3).
	box size: (size - 3) asPoint.
	
	check := box childNamed: #check.
	check geometry: (BlEllipse diameter: size - 10).
	check size: (size - 10) asPoint. 
]

{ #category : #dressing }
PenBlocRadioButtonDresser >> initEngineElement [
	| box check layout |
	
	self model engineElement: BlElement new.
	self model isLabelAfter
		ifTrue: [ 
			layout := BlLinearLayout horizontal leftToRight.
			layout alignTopLeft.
		]
		ifFalse: [ 
			layout := BlLinearLayout horizontal rightToLeft.
			layout alignTopRight.
		].
	self model engineElement layout: layout.
	self model engineElement constraintsDo: [ :c |
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
	
	self model engineElement addChild: box as: #box.
	self model engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	self model engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self model engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self model engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseDownEvent [
	self model activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseLeaveEvent [
	pushed := false.
	self model deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocRadioButtonDresser >> whenMouseUpEvent [
	pushed ifFalse: [^ self].
	self model deactivatePseudoClass: #active.
	pushed := false.
]
