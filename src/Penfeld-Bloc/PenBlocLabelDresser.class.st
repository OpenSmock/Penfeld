Class {
	#name : #PenBlocLabelDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocFontStyle + TPenBlocMarginStyle',
	#classTraits : 'TPenBlocFontStyle classTrait + TPenBlocMarginStyle classTrait',
	#instVars : [
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocLabelDresser >> backgroundColor: aValue [
	self component engineElement background: aValue value
]

{ #category : #rendering }
PenBlocLabelDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement constraintsDo: 
		[ :c | c horizontal exact: var pref ] 
	].

	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement constraintsDo: 
		[ :c | c vertical exact: var pref ] 
	].

	"Apply roped text"
	(self component engineElement childNamed: #text) text: ropedText 
]

{ #category : #dressing }
PenBlocLabelDresser >> doBeforeApplyStyle [ 
	ropedText := self component text asRopedText
]

{ #category : #styling }
PenBlocLabelDresser >> fontSize: aValue [
	self ropedText fontSize: aValue value.
	self component engineElement constraintsDo: [ :c |
		c vertical exact: aValue value ]
]

{ #category : #dressing }
PenBlocLabelDresser >> initEngineElement [
	| element |
	self component engineElement: BlElement new.
	element := self component engineElement.
	element layout: BlFrameLayout new.
	element preventMeAndChildrenMouseEvents.
	element constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	element addChild: BlTextElement new as: #text.
]

{ #category : #accessing }
PenBlocLabelDresser >> ropedText [
	^ ropedText
]

{ #category : #styling }
PenBlocLabelDresser >> textAlign: aValue [
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
