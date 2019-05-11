Class {
	#name : #PenImage,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'form'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenImage >> form [
	^ form
]

{ #category : #accessing }
PenImage >> form: anObject [
	form := anObject
]

{ #category : #accessing }
PenImage >> styleName [
	^ #form
]
