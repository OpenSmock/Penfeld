Class {
	#name : #PenSize,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #'instance creation' }
PenSize class >> width: x height: y [
	^ self new
		x: x;
		y: y;
		yourself
]

{ #category : #'instance creation' }
PenSize class >> x: x y: y [ 
	^ self new
		x: x;
		y: y;
		yourself
]

{ #category : #'instance creation' }
PenSize class >> x: x y: y z: z [
	^ self new
		x: x;
		y: y;
		z: z;
		yourself
]

{ #category : #comparing }
PenSize >> = aSize [
	^ self x = aSize x
		and: [ self y = aSize y
			and: [ self z = aSize z ] ]
]

{ #category : #converting }
PenSize >> asSize [
	^ self
]

{ #category : #accessing }
PenSize >> height [ 
	^ self y
]

{ #category : #accessing }
PenSize >> height: aNumber [
	self y: aNumber
]

{ #category : #printing }
PenSize >> printOn: aStream [
	aStream 
		nextPutAll: 'PenSize(';
		nextPutAll: self x pref printString;
		nextPut: $,;
		nextPutAll: self y pref printString;
		nextPut: $,;
		nextPutAll: self z pref printString;
		nextPut: $)
]

{ #category : #accessing }
PenSize >> width [ 
	^ self x 
]

{ #category : #accessing }
PenSize >> width: aNumber [
	self x: aNumber
]

{ #category : #accessing }
PenSize >> x [
	^ x
]

{ #category : #accessing }
PenSize >> x: aLength [
	x := aLength asLength
]

{ #category : #accessing }
PenSize >> y [
	^ y
]

{ #category : #accessing }
PenSize >> y: aLength [
	y := aLength asLength
]

{ #category : #accessing }
PenSize >> z [
	^ z ifNil: [ PenLength new ]
]

{ #category : #accessing }
PenSize >> z: aLength [
	z := aLength asLength
]
