Class {
	#name : #PenButton,
	#superclass : #PenInteractionElement,
	#instVars : [
		'text'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenButton class >> styleName [
	^ #button
]

{ #category : #accessing }
PenButton >> text [
	^ text
]

{ #category : #accessing }
PenButton >> text: anObject [
	text = anObject ifTrue: [ ^ self ].
	text := anObject.
	self refresh.
]
