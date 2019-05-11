Class {
	#name : #PenRadioButton,
	#superclass : #PenCheckBox,
	#instVars : [
		'group'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenRadioButton >> group [
	^ group
]

{ #category : #accessing }
PenRadioButton >> group: anObject [
	group := anObject
]

{ #category : #accessing }
PenRadioButton >> styleName [
	^ #radioButton
]

{ #category : #api }
PenRadioButton >> toggle [
	self value ifFalse: [ super toggle ]
]
