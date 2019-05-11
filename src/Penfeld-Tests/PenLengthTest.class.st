"
A PenLengthTest is a test class for testing the behavior of PenLength
"
Class {
	#name : #PenLengthTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Elements support'
}

{ #category : #tests }
PenLengthTest >> testAsLength [
	| res |
	res := 3 asLength.
	self assert: res class equals: PenLength.
	self assert: res pref equals: 3.
	self assert: res min isNil.
	self assert: res max isNil.
]

{ #category : #tests }
PenLengthTest >> testEquals [
	| length1 length2 |
	length1 := PenLength new.
	length1 pref: 3.
	length1 min: 1.
	length1 max: nil.
	
	length2 := PenLength new.
	length2 pref: 3.
	length2 min: 1.
	length2 max: nil.
	
	self assert: length1 equals: length2.
	
	length2 := PenLength new.
	length2 pref: 3.
	length2 min: 1.
	length2 max: 5.
	
	self deny: length1 equals: length2.
]
