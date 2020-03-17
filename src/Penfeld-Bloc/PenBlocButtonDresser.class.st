Class {
	#name : #PenBlocButtonDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'iconElement',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

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
]

{ #category : #rendering }
PenBlocButtonDresser >> doBeforeApplyStyle [ 
	| iconContainer |
	
	"Text"
	ropedText := self component text
		ifNotNil: [ self component text asRopedText ] 
		ifNil: [ '' asRopedText ].
		
	"Icon"
	self component icon ifNotNil: [ 
		iconElement 
			size: self component icon extent;
			background: self component icon asBlBackground ].
		
	animation ifNotNil: [ 
		animation isRunning ifTrue: [ animation stop ]. 
		animation := nil ].
	self component engineElement removeChildNamed: #loadingIconContainer
]

{ #category : #rendering }
PenBlocButtonDresser >> doBeforeApplyStyleOn: aComponent [
	| textElement string |
	
	"Text"
	textElement := aComponent engineElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< doBeforeApplyStyle >> There is no textElement initialized.' record ].
	string := aComponent text ifNil: [ '' ].
	textElement text: string asRopedText.
		
	"Icon"
	aComponent icon ifNotNil: [ 
		iconElement 
			size: aComponent icon extent;
			background: aComponent icon asBlBackground ].
]

{ #category : #dressing }
PenBlocButtonDresser >> initEngineElement [
	| textContainer iconContainer |
	
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
		
	"Icon"
	iconContainer := self setIcon.
	iconContainer ifNil: [ iconContainer := BlElement new ].
	self component engineElement addChild: iconContainer as: #iconContainer.
	
	"Initialisation of events"
	pushed := false.
	self component engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self component engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self component engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
	self component engineElement preventChildrenMouseEvents.
]

{ #category : #dressing }
PenBlocButtonDresser >> initEngineElementFor: aComponent [
	| textContainer iconContainer |
	
	aComponent engineElement: BlElement new.
	
	"Text is aligned in a special frame layout container"
	textContainer := BlElement new 
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
		].
	textContainer addChild: BlTextElement new as: #text.
	aComponent engineElement addChild: textContainer as: #textContainer.
		
	"Icon"
	iconContainer := self setIcon: aComponent.
	iconContainer ifNil: [ iconContainer := BlElement new ].
	aComponent engineElement addChild: iconContainer as: #iconContainer.
	
	"Initialisation of events"
	pushed := false.
	aComponent engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent: aComponent ].
	aComponent engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent: aComponent ].
	aComponent engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent: aComponent ].
	aComponent engineElement preventChildrenMouseEvents.
]

{ #category : #'accessing - font' }
PenBlocButtonDresser >> ropedText [
	^ ropedText
]

{ #category : #dressing }
PenBlocButtonDresser >> setIcon [
	
	| iconContainer |

	self component icon ifNil: [ ^ nil ].
		
	"Icon is by default centered on left side of the button"
	iconContainer := BlElement new layout: BlFrameLayout new.
	
	self component text 
		ifNil: [ 
			"Icon centered"
			iconContainer constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
		]
		ifNotNil: [ 
			"Icon on left"
			iconContainer constraintsDo: [ :c | 
				c padding: (BlInsets left: 5).
				c horizontal exact: self component icon extent x + 5.
				c vertical matchParent ].
		].
	
	iconElement ifNil: [ 
		iconElement := BlElement new
			size: self component icon extent;
			background: self component icon asBlBackground;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
	].

	iconContainer addChild: iconElement as: #icon.
	^ iconContainer
	
]

{ #category : #dressing }
PenBlocButtonDresser >> setIcon: aComponent [
	
	| iconContainer |

	aComponent icon ifNil: [ ^ nil ].
		
	"Icon is by default centered on left side of the button"
	iconContainer := BlElement new layout: BlFrameLayout new.
	
	aComponent text 
		ifNil: [ 
			"Icon centered"
			iconContainer constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
		]
		ifNotNil: [ 
			"Icon on left"
			iconContainer constraintsDo: [ :c | 
				c padding: (BlInsets left: 5).
				c horizontal exact: aComponent icon extent x + 5.
				c vertical matchParent ].
		].
	
	iconElement ifNil: [ 
		iconElement := BlElement new
			size: aComponent icon extent;
			background: aComponent icon asBlBackground;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
	].

	iconContainer addChild: iconElement as: #icon.
	^ iconContainer
	
]

{ #category : #styling }
PenBlocButtonDresser >> text: aModel onBl: anElement [
	| textElement |
	super text: aModel onBl: anElement. 
	
	textElement := anElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< text >> There is no textElement initialized.'. ^ self].
		
	"Vertical alignment center"
	textElement constraintsDo: [ :c | c frame vertical alignCenter ].
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
PenBlocButtonDresser >> whenMouseDownEvent: aComponent [
	aComponent isDisabled ifTrue: [ ^ self ].
	aComponent activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseLeaveEvent [
	self component isDisabled ifTrue: [ ^ self ].
	pushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseLeaveEvent: aComponent [
	aComponent isDisabled ifTrue: [ ^ self ].
	pushed := false.
	aComponent deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseUpEvent [
	self component isDisabled ifTrue: [ ^ self ].
	pushed ifFalse: [^ self].
	self component deactivatePseudoClass: #active.
	pushed := false.
]

{ #category : #events }
PenBlocButtonDresser >> whenMouseUpEvent: aComponent [
	aComponent isDisabled ifTrue: [ ^ self ].
	pushed ifFalse: [^ self].
	aComponent deactivatePseudoClass: #active.
	pushed := false.
]
