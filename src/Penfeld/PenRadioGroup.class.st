Class {
	#name : #PenRadioGroup,
	#superclass : #PenInteractionElement,
	#traits : 'TPenSelectionChangedEvent',
	#classTraits : 'TPenSelectionChangedEvent classTrait',
	#instVars : [
		'checkedButton',
		'radioButtons'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #adding }
PenRadioGroup >> add: aRadioButton [
	self radioButtons add: aRadioButton.
	aRadioButton uncheck.
	aRadioButton onCheckedDo: [ self buttonStateChange: aRadioButton ].
	
	self radioButtons size = 1 ifTrue: [ aRadioButton check ]
]

{ #category : #adding }
PenRadioGroup >> addAll: aList [
	aList do: [ :e | self add: e ]
]

{ #category : #building }
PenRadioGroup >> build [
	self radioButtons do: [ :e | e build ].
	super build
]

{ #category : #events }
PenRadioGroup >> buttonStateChange: aRadioButton [
	checkedButton = aRadioButton ifTrue: [ ^ self ].
	checkedButton ifNotNil: [ checkedButton uncheck ].
	checkedButton := aRadioButton.
]

{ #category : #initialization }
PenRadioGroup >> initialize [ 
	super initialize.
	radioButtons := OrderedCollection new
]

{ #category : #accessing }
PenRadioGroup >> radioButtons [
	^ radioButtons
]

{ #category : #events }
PenRadioGroup >> selectionChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol selectionChanged)
			ifTrue: [ eventBinding callback value ]].
]

{ #category : #accessing }
PenRadioGroup >> styleName [ 
	^ #container
]
