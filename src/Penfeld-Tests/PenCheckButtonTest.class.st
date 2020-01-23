"
A PenCheckButtonTest is a test class for testing the behavior of PenCheckButton
"
Class {
	#name : #PenCheckButtonTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Elements'
}

{ #category : #test }
PenCheckButtonTest >> testOnCheckedDo [
	| component i |
	i := 0.
	component := PenCheckButton new.
	component value: false.
	component onCheckedDo: [ i := i + 1 ].
	
	component value: true.
	self assert: i equals: 1.
	
	component value: true.
	self assert: i equals: 1.
	
	component value: false.
	self assert: i equals: 1.
	
	component value: true.
	self assert: i equals: 2.
]

{ #category : #test }
PenCheckButtonTest >> testOnCheckedDo2Subscribptions [
	| component i |
	i := 0.
	component := PenCheckButton new.
	component value: false.
	component onCheckedDo: [ i := i + 2 ].
	component onCheckedDo: [ i := i - 1 ].
	
	component toggle.
	self assert: i equals: 1.
]

{ #category : #test }
PenCheckButtonTest >> testOnUncheckedDo [
	| component i |
	i := 0.
	component := PenCheckButton new.
	component value: false.
	component onUncheckedDo: [ i := i + 1 ].
	
	component value: true.
	self assert: i equals: 0.
	
	component value: false.
	self assert: i equals: 1.
	
	component value: false.
	self assert: i equals: 1.
	
	component value: true.
	self assert: i equals: 1.
	
	component value: false.
	self assert: i equals: 2.
]

{ #category : #test }
PenCheckButtonTest >> testOnValueChangedDo [
	| component i |
	i := 0.
	component := PenCheckButton new.
	component value: false.
	component onValueChangedDo: [ i := i + 1 ].
	
	component value: true.
	self assert: i equals: 1.
	
	component value: true.
	self assert: i equals: 1.
	
	component value: false.
	self assert: i equals: 2.
]

{ #category : #tests }
PenCheckButtonTest >> testToggle [
	| component |
	component := PenCheckButton new.
	
	component value: false.
	self deny: component value.
	
	component toggle.
	self assert: component value.
	
	component toggle.
	self deny: component value.
]
