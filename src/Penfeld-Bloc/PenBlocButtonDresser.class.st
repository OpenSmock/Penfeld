Class {
	#name : #PenBlocButtonDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'ropedText',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocButtonDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
PenBlocButtonDresser >> backgroundImage: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
PenBlocButtonDresser >> border: aValue [
	| borderBuilder |	
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
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	self model engineElement border: borderBuilder build.
]

{ #category : #styling }
PenBlocButtonDresser >> color: aValue [
	ropedText foreground: aValue
]

{ #category : #rendering }
PenBlocButtonDresser >> doAfterApplyStyle [ 
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
		ifNone: []
]

{ #category : #rendering }
PenBlocButtonDresser >> doBeforeApplyStyle [ 
	ropedText := self model text asRopedText
]

{ #category : #styling }
PenBlocButtonDresser >> fontFamily: aValue [
	ropedText fontName: aValue first.
]

{ #category : #styling }
PenBlocButtonDresser >> fontSize: aValue [
	ropedText fontSize: aValue value.
]

{ #category : #styling }
PenBlocButtonDresser >> fontWeight: aValue [
	| symbol |
	symbol := aValue value.
	(ropedText respondsTo: symbol)
		ifTrue: [ ropedText perform: symbol ]
		ifFalse: [ self halt: 'todo' ]
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
	self model activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseLeaveEvent [
	pushed := false.
	self model deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseUpEvent [
	pushed ifFalse: [^ self].
	self model deactivatePseudoClass: #active.
	pushed := false.
]

{ #category : #styling }
PenBlocButtonDresser >> width: aValue [
	self model engineElement width: aValue
]
