Class {
	#name : #PenForm,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'form'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenForm >> form [
	^ form
]

{ #category : #accessing }
PenForm >> form: anObject [
	form := anObject
]

{ #category : #accessing }
PenForm >> styleName [
	^ #form
]
