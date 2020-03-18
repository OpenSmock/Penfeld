Class {
	#name : #PenBlocLabelDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

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
