Class {
	#name : #PenShape,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'shape',
		'fillColor',
		'strokeColor',
		'strokeStyle'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenShape class >> styleName [
	^ #shape
]

{ #category : #accessing }
PenShape >> fillColor [
	^ fillColor
]

{ #category : #accessing }
PenShape >> fillColor: aColor [
	fillColor = aColor ifTrue: [ ^ self ].
	fillColor := aColor.
	self refresh.
]

{ #category : #accessing }
PenShape >> shape [
	^ shape
]

{ #category : #accessing }
PenShape >> shape: anObject [
	shape := anObject
]

{ #category : #accessing }
PenShape >> strokeColor [
	^ strokeColor
]

{ #category : #accessing }
PenShape >> strokeColor: anObject [
	strokeColor := anObject
]

{ #category : #accessing }
PenShape >> strokeStyle [
	^ strokeStyle
]

{ #category : #accessing }
PenShape >> strokeStyle: anObject [
	strokeStyle := anObject
]
