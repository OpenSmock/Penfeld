Class {
	#name : #PenButton,
	#superclass : #PenInteractionElement,
	#instVars : [
		'text',
		'icon'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenButton >> styleName [
	^ #button
]

{ #category : #accessing }
PenButton >> text [
	^ text
]

{ #category : #accessing }
PenButton >> text: anObject [
	text := anObject
]
