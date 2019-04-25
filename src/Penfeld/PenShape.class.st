Class {
	#name : #PenShape,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'shape'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenShape >> shape [
	^ shape
]

{ #category : #accessing }
PenShape >> shape: anObject [
	shape := anObject
]

{ #category : #accessing }
PenShape >> styleName [
	^ #shape
]
