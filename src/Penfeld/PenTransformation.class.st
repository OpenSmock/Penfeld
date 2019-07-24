Class {
	#name : #PenTransformation,
	#superclass : #Object,
	#instVars : [
		'translation',
		'translationUnit',
		'rotation',
		'rotationCenter',
		'scale',
		'scaleCenter'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #accessing }
PenTransformation >> rotation [
	^ rotation
]

{ #category : #accessing }
PenTransformation >> rotation: anObject [
	rotation := anObject
]

{ #category : #accessing }
PenTransformation >> rotationCenter [
	^ rotationCenter
]

{ #category : #accessing }
PenTransformation >> rotationCenter: anObject [
	rotationCenter := anObject
]

{ #category : #accessing }
PenTransformation >> scale [
	^ scale
]

{ #category : #accessing }
PenTransformation >> scale: anObject [
	scale := anObject
]

{ #category : #accessing }
PenTransformation >> scaleCenter [
	^ scaleCenter
]

{ #category : #accessing }
PenTransformation >> scaleCenter: anObject [
	scaleCenter := anObject
]

{ #category : #accessing }
PenTransformation >> translation [
	^ translation
]

{ #category : #accessing }
PenTransformation >> translation: anObject [
	translation := anObject
]

{ #category : #accessing }
PenTransformation >> translationUnit [
	^ translationUnit
]

{ #category : #accessing }
PenTransformation >> translationUnit: anObject [
	translationUnit := anObject
]
