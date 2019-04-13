Class {
	#name : #PenBlocButtonDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocSizeStyle + TPenBlocBackgroundStyle + TPenBlocFontStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocSizeStyle classTrait + TPenBlocBackgroundStyle classTrait + TPenBlocFontStyle classTrait + TPenBlocBorderStyle classTrait',
	#instVars : [
		'ropedText',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocButtonDresser >> border: aValue [
	| borderBuilder |	
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
						paint end: paint end * (self component width pref @ self component height pref).
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
	
	self component engineElement border: borderBuilder build.
]

{ #category : #rendering }
PenBlocButtonDresser >> doAfterApplyStyle [ 
	| var element |
	element := self component engineElement.

	"Position"
	var := self component position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ element width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ element height: var pref ].
	
	"Apply roped text"
	element childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
	
	self component isLoading 
		ifTrue: 
		[ 
			element childNamed: #loader
				ifFound: [ :anElement |  ]
				ifNone: [ element addChild: self loader as: #loader ]
		]
		ifFalse: [ element removeChildNamed: #loader ].
]

{ #category : #rendering }
PenBlocButtonDresser >> doBeforeApplyStyle [ 
	ropedText := self component text asRopedText
]

{ #category : #dressing }
PenBlocButtonDresser >> initEngineElement [
	| textContainer |
	
	self component engineElement: BlElement new.
	
	"Text is aligned in a special frame layout container"
	textContainer := BlElement new 
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
		].
	textContainer addChild: BlTextElement new as: #text.
	self component engineElement addChild: textContainer as: #textContainer.
	
	"Icon is by default centered on left side of the button"
	self component icon ifNotNil: [ | iconContainer iconElement |
		iconContainer := BlElement new 
			layout: BlFrameLayout new;
			relocate: 5@0;
			constraintsDo: [ :c | 
				c horizontal exact: self component icon extent x.
				c vertical matchParent ].
		iconElement := BlElement new
			size: self component icon extent;
			background: self component icon asBlBackground;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].
		iconContainer addChild: iconElement as: #icon.
		self component engineElement addChild: iconContainer as: #iconContainer 
	].
	
	"Initialisation of events"
	pushed := false.
	self component engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self component engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self component engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #accessing }
PenBlocButtonDresser >> ropedText [
	^ ropedText
]

{ #category : #styling }
PenBlocButtonDresser >> textAlign: aValue [
	| textElement |
	textElement := self component engineElement childNamed: #text
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
	self component isDisabled ifTrue: [ ^ self ].
	self component activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseLeaveEvent [
	self component isDisabled ifTrue: [ ^ self ].
	pushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseUpEvent [
	self component isDisabled ifTrue: [ ^ self ].
	pushed ifFalse: [^ self].
	self component deactivatePseudoClass: #active.
	pushed := false.
]
