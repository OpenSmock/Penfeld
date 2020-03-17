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

{ #category : #'instance creation' }
PenCheckButton class >> new [ 
	^ self basicNew initialize; autoBindToggle; yourself
]

{ #category : #'instance creation' }
PenCheckButton class >> wait [
	^ self basicNew initialize
]

{ #category : #private }
PenCheckButton >> autoBindToggle [
	self onActionDo: [ self toggle ].
]

{ #category : #api }
PenCheckButton >> check [
	(self setValue: true) ifTrue: [ self valueChangedEvent ].
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
PenCheckButton >> setValue: aBoolean [
	value = aBoolean ifTrue: [ ^ false ].
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
	self refresh.
	^ true
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
	self setValue: self value not.
	self valueChangedEvent.
]

{ #category : #api }
PenCheckButton >> uncheck [
	(self setValue: false) ifTrue: [ self valueChangedEvent ].
]

{ #category : #accessing }
PenCheckButton >> value [
	^ value
]

{ #category : #accessing }
PenCheckButton >> value: aBoolean [
	(self setValue: aBoolean) ifTrue: [ self valueChangedEvent ]
]
