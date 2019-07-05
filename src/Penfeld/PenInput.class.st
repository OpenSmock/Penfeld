Class {
	#name : #PenInput,
	#superclass : #PenInteractionElement,
	#traits : 'TPenValueChangedEvent',
	#classTraits : 'TPenValueChangedEvent classTrait',
	#instVars : [
		'text'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenInput class >> styleName [
	^ #input
]

{ #category : #accessing }
PenInput >> text: aString [
	aString = text ifTrue: [ ^ self ].
	
	text := aString.
	self refresh.
	self valueChangedEvent.
]
