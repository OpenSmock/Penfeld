"
CheckBox or RadioButton.
They have not difference in their model.

text or label ?
"
Class {
	#name : #PenCheckBox,
	#superclass : #PenCheckButton,
	#instVars : [
		'labelPosition'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #initialization }
PenCheckBox >> initialize [
	super initialize.
	labelPosition := #after
]

{ #category : #testing }
PenCheckBox >> isLabelAfter [
	^ labelPosition = #after
]

{ #category : #testing }
PenCheckBox >> isLabelBefore [
	^ labelPosition = #before
]

{ #category : #accessing }
PenCheckBox >> labelAfter [
	labelPosition := #after.
]

{ #category : #accessing }
PenCheckBox >> labelBefore [
	labelPosition := #before.
]

{ #category : #accessing }
PenCheckBox >> styleName [
	^ #checkBox
]
