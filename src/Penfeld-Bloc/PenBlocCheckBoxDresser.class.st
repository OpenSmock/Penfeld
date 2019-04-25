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
PenBlocCheckBoxDresser >> backgroundColor: aValue [
	| box |
	box := self component engineElement childNamed: #box.
	box background: aValue
]

{ #category : #styling }
PenBlocCheckBoxDresser >> border: aValue [
	| borderBuilder box |
	box := self component engineElement childNamed: #box.	
	borderBuilder := BlBorderBuilder new.
	
	aValue do: 
	[ :property | 
		property value isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property value isSymbol
			ifTrue: 
			[ 
				(borderBuilder respondsTo: property value) 
				ifTrue: [ borderBuilder perform: property value ]
				ifFalse: 
				[
					(property isKindOf: PssValue)
					ifTrue: 
					[ 
						"Linear gradient" 
						| paint |
						paint := self performFunction: property.
						paint end: paint end * box extent.
						borderBuilder paint: paint
					]
				]
			]
			ifFalse: 
			[ 
				(property value isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	
	box border: borderBuilder build.
]

{ #category : #styling }
PenBlocCheckBoxDresser >> color: aValue [
	| textElement |
	textElement := self component engineElement childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement text foreground: aValue
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> doAfterApplyStyle [ 
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
PenBlocCheckBoxDresser >> doBeforeApplyStyle [ 
	(self component engineElement childNamed: #check) visibility: (self component value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).
		
	ropedText := self component text asRopedText

]

{ #category : #styling }
PenBlocCheckBoxDresser >> fontFamily: aValue [
	ropedText fontName: aValue first.
]

{ #category : #styling }
PenBlocCheckBoxDresser >> fontSize: aValue [
	| size box check |
	size := aValue value.

	ropedText fontSize: size.
	
	size := size - 3.
	
	box := self component engineElement childNamed: #box.
	box size: size asPoint.
	
	check := box childNamed: #check.
	check geometry: (BlPolyline vertices: 
	{ 
		(0.18 * size) rounded @ (0.55 * size) rounded. 
		(0.36 * size) rounded @ (0.91 * size) rounded. 
		(0.91 * size) rounded @ (0.27 * size) rounded
	}).
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> initEngineElement [
	| box check |
	
	self component engineElement: BlElement new.
	self component isLabelAfter
		ifTrue: [ self component engineElement layout: BlLinearLayout horizontal leftToRight ]
		ifFalse: [ self component engineElement layout: BlLinearLayout horizontal rightToLeft ].
	self component engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	check := BlElement new.
	check geometry: (BlPolyline vertices: {2@6. 4@10. 10@3}). self flag: #moveInStyle.
	
	box := BlElement new.
	box addChild: check as: #check.
	box size: 14 @ 14. self flag: #moveInStyle.
	
	self component engineElement addChild: box as: #box.
	self component engineElement addChild: BlTextElement new as: #text.
	
	pushed := false.
	self component engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self component engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self component engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseDownEvent [
	self component activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseLeaveEvent [
	pushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseUpEvent [
	pushed ifFalse: [^ self].
	self component deactivatePseudoClass: #active.
	pushed := false.
]
