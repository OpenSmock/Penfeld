Class {
	#name : #PenRadioGroup,
	#superclass : #PenComponent,
	#instVars : [
		'checkedButton',
		'radioButtons'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #adding }
PenRadioGroup >> add: aRadioButton [
	self radioButtons add: aRadioButton.
	aRadioButton group: self.
	aRadioButton uncheck.
	aRadioButton onCheckedDo: [ self buttonStateChange: aRadioButton ].
]

{ #category : #adding }
PenRadioGroup >> addAll: aList [
	aList do: [ :e | self add: e ]
]

{ #category : #events }
PenRadioGroup >> buttonStateChange: aRadioButton [
	checkedButton = aRadioButton ifTrue: [ ^ self ].
	checkedButton ifNotNil: [ checkedButton uncheck ].
	checkedButton := aRadioButton.
	self selectionChangedEvent
]

{ #category : #accessing }
PenRadioGroup >> checkedButton [
	^ checkedButton
]

{ #category : #initialization }
PenRadioGroup >> initialize [ 
	super initialize.
	radioButtons := OrderedCollection new
]

{ #category : #'api - events' }
PenRadioGroup >> onSelectionChangedDo: aBlock [
	self onEvent: PenEventSymbol selectionChanged do: aBlock
]

{ #category : #accessing }
PenRadioGroup >> radioButtons [
	^ radioButtons
]

{ #category : #events }
PenRadioGroup >> selectionChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol selectionChanged)
			ifTrue: [ eventBinding executeCallback: checkedButton ]].
]
