"
A PenComponentTest is a test class for testing the behavior of PenComponent
"
Class {
	#name : #PenComponentTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Components'
}

{ #category : #tests }
PenComponentTest >> testHeight [
	| component |
	component := PenComponent new.
	
	"Height must be nil"
	self assert: component height equals: nil.
	
	component height: 200.
	self assert: component height equals: 200 asLength.
	
]

{ #category : #tests }
PenComponentTest >> testSize [ 
	| component |
	component := PenComponent new.
	self assert: component size equals: nil.
	
	component size: 200@300.
	self assert: component size class equals: PenSize.
	self assert: component size x equals: 200 asLength.
	self assert: component size y equals: 300 asLength.
	
]

{ #category : #tests }
PenComponentTest >> testSize2 [
	| component |
	component := PenComponent new.
	self assert: component width equals: nil.
	self assert: component height equals: nil.
	
	component width: 200.
	self assert: component width equals: 200 asLength.
	self assert: component height equals: nil.
	
]

{ #category : #tests }
PenComponentTest >> testWidth [
	| component |
	component := PenComponent new.
	
	"Width must be nil"
	self assert: component width equals: nil.
	
	component width: 200.
	self assert: component width equals: 200 asLength.
	
]
