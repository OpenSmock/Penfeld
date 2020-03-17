Class {
	#name : #PenLength,
	#superclass : #Object,
	#instVars : [
		'pref',
		'min',
		'max'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #testing }
PenLength class >> isDeprecated [
	^ true
]

{ #category : #'instance creation' }
PenLength class >> pref: aNumber [
	^ self new pref: aNumber
]

{ #category : #'instance creation' }
PenLength class >> pref: aNumber min: aNumber2 max: aNumber3 [
	^ self new 
		pref: aNumber;
		min: aNumber2;
		max: aNumber3
]

{ #category : #comparing }
PenLength >> = aLength [
	^ self pref = aLength pref 
		and: [ self min = aLength min 
			and: [ self max = aLength max ] ]
]

{ #category : #converting }
PenLength >> asLength [
	^ self
]

{ #category : #accessing }
PenLength >> max [
	^ max
]

{ #category : #accessing }
PenLength >> max: aNumber [
	max := aNumber.
	self sendResizeEvent.
]

{ #category : #accessing }
PenLength >> min [
	^ min
]

{ #category : #accessing }
PenLength >> min: aNumber [
	min := aNumber.
	self sendResizeEvent.
]

{ #category : #accessing }
PenLength >> pref [
	^ pref
]

{ #category : #accessing }
PenLength >> pref: aNumber [
	pref := aNumber.
	self sendResizeEvent.
]

{ #category : #printing }
PenLength >> printOn: aStream [
	| minmax |
	minmax := self min notNil or: [ self max notNil ].
	
	aStream nextPut: $<.
	
	minmax ifTrue: [ 
		aStream nextPutAll: self min printString.
		aStream nextPut: $,.
	].

	aStream nextPutAll: self pref printString.
	
	minmax ifTrue: [ 
		aStream nextPut: $,.
		aStream nextPutAll: self max printString.
	].
	
	aStream nextPut: $>.
]

{ #category : #'events-triggering' }
PenLength >> sendResizeEvent [
	self triggerEvent: #resize
]
