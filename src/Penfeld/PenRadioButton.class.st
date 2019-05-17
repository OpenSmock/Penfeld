Class {
	#name : #PenRadioButton,
	#superclass : #PenCheckBox,
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenRadioButton class >> styleName [
	^ #radioButton
]

{ #category : #api }
PenRadioButton >> toggle [
	self value ifFalse: [ super toggle ]
]
