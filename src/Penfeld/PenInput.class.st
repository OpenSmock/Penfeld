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

{ #category : #initialization }
PenInput >> defaultText [ 
	^ ''
]

{ #category : #initialization }
PenInput >> initialize [ 
	super initialize.
	text := self defaultText.
]

{ #category : #accessing }
PenInput >> text [ 
	^ text
]

{ #category : #accessing }
PenInput >> text: aString [
	aString = text ifTrue: [ ^ self ].
	
	text := aString.
	self refresh.
	self valueChangedEvent.
]
