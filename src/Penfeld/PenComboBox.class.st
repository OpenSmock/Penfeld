"
keep expand here, or combo box is no more than a selectionable list ?
"
Class {
	#name : #PenComboBox,
	#superclass : #PenList,
	#instVars : [
		'expanded'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #api }
PenComboBox >> expand [
	self expanded: true.
	self refresh
]

{ #category : #accessing }
PenComboBox >> expanded [
	^ expanded
]

{ #category : #accessing }
PenComboBox >> expanded: anObject [
	expanded := anObject.
	self refresh.
]

{ #category : #initialization }
PenComboBox >> initialize [
	super initialize.
	expanded := false.
	allowToSelect := true.
	self addStyleClass: #cbbutton.
]

{ #category : #testing }
PenComboBox >> isExpanded [
	^ self expanded
]

{ #category : #selecting }
PenComboBox >> select: anItem [
	anItem ifNil: [ ^self ].
	super select: anItem.
	self flag: 'temp : there is a pb with a click event received twice'.
	self refresh
]

{ #category : #accessing }
PenComboBox >> selectedItemString [
	self selectedIndexList isEmpty ifTrue: [ ^ '' ].
	^ (self items at: self selection) text. 
]

{ #category : #accessing }
PenComboBox >> selection [
	^ super selection first
]

{ #category : #accessing }
PenComboBox >> styleName [
	^ #comboBox
]

{ #category : #api }
PenComboBox >> switchExpand [
	self expanded: self expanded not.
]
