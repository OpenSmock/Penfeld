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
	self model interactor background: aValue
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
	self model interactor border: borderBuilder build.
]

{ #category : #styling }
PenBlocButtonDresser >> color: aValue [
	| textElement |
	textElement := self model interactor childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement text foreground: aValue
]

{ #category : #rendering }
PenBlocButtonDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model interactor width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model interactor height: var pref ].
	
	"Apply roped text"
	self model interactor childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
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
PenBlocButtonDresser >> height: aValue [
	self model interactor height: aValue
]

{ #category : #dressing }
PenBlocButtonDresser >> initInteractor [
	self model interactor: BlElement new.
	self model interactor layout: BlFrameLayout new.
	self model interactor addChild: BlTextElement new as: #text.
	
	pushed := false.
	self model interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self model interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self model interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #styling }
PenBlocButtonDresser >> textAlign: aValue [
	| textElement |
	textElement := self model interactor childNamed: #text
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
	self model interactor width: aValue
]
