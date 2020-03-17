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

{ #category : #'styling - font' }
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
	self component hasEvents ifFalse: [ element preventMeAndChildrenMouseEvents ].
	element constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	element addChild: BlTextElement new as: #text.
]

{ #category : #dressing }
PenBlocLabelDresser >> initEngineElementFor: aComponent [
	| element |
	aComponent engineElement: BlElement new.
	element := aComponent engineElement.
	element layout: BlFrameLayout new.
	aComponent hasEvents ifFalse: [ element preventMeAndChildrenMouseEvents ].
	element constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	element addChild: BlTextElement new as: #text.
]

{ #category : #'accessing - font' }
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
		c frame vertical alignCenter.
		aValue = #center 
			ifTrue: [ c frame horizontal alignCenter ]
			ifFalse: [ 
				aValue = #right 
					ifTrue: [ c frame horizontal alignRight ] 
					ifFalse: [ 
						aValue = #left 
							ifTrue: [ c frame horizontal alignLeft ]
							ifFalse: [  self notYetImplemented ] ] ] ].
]
