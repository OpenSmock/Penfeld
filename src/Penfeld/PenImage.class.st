Class {
	#name : #PenImage,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'form'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenImage class >> styleName [
	^ #form
]

{ #category : #accessing }
PenImage >> form [
	^ form
]

{ #category : #accessing }
PenImage >> form: anObject [
	form := anObject.
	self refresh
]
