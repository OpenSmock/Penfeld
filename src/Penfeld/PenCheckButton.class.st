Class {
	#name : #PenCheckButton,
	#superclass : #PenInteractionElement,
	#traits : 'TPenValueChangedEvent',
	#classTraits : 'TPenValueChangedEvent classTrait',
	#instVars : [
		'value',
		'text',
		'group'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #api }
PenCheckButton >> check [
	self value: true
]

{ #category : #accessing }
PenCheckButton >> group [
	^ group
]

{ #category : #accessing }
PenCheckButton >> group: anObject [
	group := anObject
]

{ #category : #initialization }
PenCheckButton >> initialize [
	super initialize.
	self value: false.
	self onActionDo: [ self toggle ].
]

{ #category : #'api - events' }
PenCheckButton >> onCheckedDo: aBlock [
	self onValueChangedDo: [ self value ifTrue: [ aBlock value ] ] 
]

{ #category : #'api - events' }
PenCheckButton >> onUncheckedDo: aBlock [
	self onValueChangedDo: [ self value ifFalse: [ aBlock value ] ] 
]

{ #category : #accessing }
PenCheckButton >> text [
	^ text
]

{ #category : #accessing }
PenCheckButton >> text: aString [
	text = aString ifTrue: [ ^ self ].
	text := aString.
	self refresh.
]

{ #category : #api }
PenCheckButton >> toggle [
	self value: self value not
]

{ #category : #api }
PenCheckButton >> uncheck [
	self value: false
]

{ #category : #accessing }
PenCheckButton >> value [
	^ value
]

{ #category : #accessing }
PenCheckButton >> value: aBoolean [
	value = aBoolean 
		ifTrue: [ ^ self ].
	value := aBoolean.
	value 
	ifTrue: [ 
		self activatePseudoClass: #checked.
		self deactivatePseudoClass: #unchecked
	]
	ifFalse: [ 
		self activatePseudoClass: #unchecked.
		self deactivatePseudoClass: #checked 
	].
	self valueChangedEvent.
	self refresh
]
