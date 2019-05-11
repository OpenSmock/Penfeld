Class {
	#name : #PenShape,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'shape'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenShape class >> styleName [
	^ #shape
]

{ #category : #accessing }
PenShape >> shape [
	^ shape
]

{ #category : #accessing }
PenShape >> shape: anObject [
	shape := anObject
]
