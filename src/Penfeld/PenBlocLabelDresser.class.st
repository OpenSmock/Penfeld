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
	self model interactor background: aValue
]

{ #category : #styling }
PenBlocLabelDresser >> color: aValue [
	self model interactor text foreground: aValue
]

{ #category : #rendering }
PenBlocLabelDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Apply roped text"
	self model interactor text: ropedText 
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
PenBlocLabelDresser >> initInteractor [
	self model interactor: BlTextElement new.
]

{ #category : #styling }
PenBlocLabelDresser >> textAlign: aValue [
	self model interactor constraintsDo: [:c | 
		aValue = #center 
		ifTrue: [ 
			c frame horizontal alignCenter.
			c frame vertical alignCenter
		]
		ifFalse: [ self notYetImplemented  ] ].
]
