"
A PenComponentTest is a test class for testing the behavior of PenComponent
"
Class {
	#name : #PenComponentTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Components'
}

{ #category : #test }
PenComponentTest >> testHeight [
	| component |
	component := PenComponent new.
	
	"Height must be nil"
	self assert: component height equals: nil.
	
	component height: 200.
	self assert: component height equals: 200 asLength.
	
]

{ #category : #test }
PenComponentTest >> testResizeEvent [
	| component i |
	component := PenComponent new.
	i := 0.
	
	component onResizeDo: [ i := i + 1 ].
	
	component size: 600@400.
	self assert: i equals: 1.
	self assert: component size equals: (600@400) asSize.
	
	component size x: 700.
	self assert: i equals: 2.
	self assert: component size equals: (700@400) asSize.
	
	component size x min: 200.
	self assert: i equals: 3.
	self assert: component size x min equals: 200.
]

{ #category : #test }
PenComponentTest >> testSize [ 
	| component |
	component := PenComponent new.
	self assert: component size equals: nil.
	
	component size: 200@300.
	self assert: component size class equals: PenSize.
	self assert: component size x equals: 200 asLength.
	self assert: component size y equals: 300 asLength.
	
]

{ #category : #test }
PenComponentTest >> testSizeXNil [
	| component |
	component := PenComponent new.
	self assert: component width equals: nil.
	self assert: component height equals: nil.
	
	component height: 200.
	self assert: component height equals: 200 asLength.
	self assert: component width equals: nil.
	
]

{ #category : #test }
PenComponentTest >> testSizeYNil [
	| component |
	component := PenComponent new.
	self assert: component width equals: nil.
	self assert: component height equals: nil.
	
	component width: 200.
	self assert: component width equals: 200 asLength.
	self assert: component height equals: nil.
	
]

{ #category : #test }
PenComponentTest >> testWidth [
	| component |
	component := PenComponent new.
	
	"Width must be nil"
	self assert: component width equals: nil.
	
	component width: 200.
	self assert: component width equals: 200 asLength.
	
]
