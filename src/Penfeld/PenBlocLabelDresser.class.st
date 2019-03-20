Class {
	#name : #PenBlocLabelDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocLabelDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
PenBlocLabelDresser >> color: aValue [
	self model engineElement text foreground: aValue
]

{ #category : #rendering }
PenBlocLabelDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Apply roped text"
	self model engineElement text: ropedText 
]

{ #category : #dressing }
PenBlocLabelDresser >> doBeforeApplyStyle [ 
	ropedText := self model text asRopedText
]

{ #category : #styling }
PenBlocLabelDresser >> fontFamily: aValue [
	ropedText fontName: aValue first value.
]

{ #category : #styling }
PenBlocLabelDresser >> fontSize: aValue [
	ropedText fontSize: aValue value.
]

{ #category : #dressing }
PenBlocLabelDresser >> initEngineElement [
	self model engineElement: BlTextElement new.
]

{ #category : #styling }
PenBlocLabelDresser >> textAlign: aValue [
	self model engineElement constraintsDo: [:c | 
		aValue = #center 
		ifTrue: [ 
			c frame horizontal alignCenter.
			c frame vertical alignCenter
		]
		ifFalse: [ self notYetImplemented  ] ].
]
