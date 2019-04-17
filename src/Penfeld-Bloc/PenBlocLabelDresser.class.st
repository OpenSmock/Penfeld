Class {
	#name : #PenBlocLabelDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocFontStyle',
	#classTraits : 'TPenBlocFontStyle classTrait',
	#instVars : [
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocLabelDresser >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #rendering }
PenBlocLabelDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Apply roped text"
	self component engineElement text: ropedText 
]

{ #category : #dressing }
PenBlocLabelDresser >> doBeforeApplyStyle [ 
	ropedText := self component text asRopedText
]

{ #category : #dressing }
PenBlocLabelDresser >> initEngineElement [
	self component engineElement: BlTextElement new.
]

{ #category : #accessing }
PenBlocLabelDresser >> ropedText [
	^ ropedText
]

{ #category : #styling }
PenBlocLabelDresser >> textAlign: aValue [
	self component engineElement constraintsDo: [:c | 
		aValue = #center 
		ifTrue: [ 
			c frame horizontal alignCenter.
			c frame vertical alignCenter
		]
		ifFalse: [ self notYetImplemented  ] ].
]
