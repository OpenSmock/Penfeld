"
A PenSizeTest is a test class for testing the behavior of PenSize
"
Class {
	#name : #PenSizeTest,
	#superclass : #TestCase,
	#instVars : [
		'size'
	],
	#category : #'Penfeld-Tests-Elements support'
}

{ #category : #tests }
PenSizeTest >> testEquals [
	| size1 size2 |
	
	size1 := PenSize x: 200 y: 300.
	size2 := PenSize x: 300 y: 300.
	self deny: size1 equals: size2.
	
	size2 x: 200.
	self assert: size1 equals: size2.
	
	size2 z: 400.
	self deny: size1 equals: size2.
]

{ #category : #tests }
PenSizeTest >> testX [
	size := PenSize new x: 3.
	self assert: size x pref equals: 3.
	self assert: size width pref equals: 3.
]

{ #category : #tests }
PenSizeTest >> testY [
	size := PenSize new y: 3.
	self assert: size y pref equals: 3.
	self assert: size height pref equals: 3.
]
