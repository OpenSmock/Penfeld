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
	self deprecated: 'Use stylesheet instead'.
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
	shape ifNil: [ ^ GRectangle 
		origin: self position asGPoint 
		corner: (self position + (self width pref @ self height pref)) asGPoint ].
	^ shape
]

{ #category : #accessing }
PenShape >> shape: aGShape [
	shape := aGShape
]

{ #category : #accessing }
PenShape >> strokeColor [
	self deprecated: 'Use stylesheet instead'.
	^ strokeColor
]

{ #category : #accessing }
PenShape >> strokeColor: anObject [
	self deprecated: 'Use stylesheet instead'.
	strokeColor := anObject
]

{ #category : #accessing }
PenShape >> strokeStyle [
	self deprecated: 'Use stylesheet instead'.
	^ strokeStyle
]

{ #category : #accessing }
PenShape >> strokeStyle: anObject [
	self deprecated: 'Use stylesheet instead'.
	strokeStyle := anObject
]
