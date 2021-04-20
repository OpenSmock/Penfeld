"
A PenComponentTest is a test class for testing the behavior of PenComponent
"
Class {
	#name : #PenComponentTest,
	#superclass : #TestCase,
	#instVars : [
		'status'
	],
	#category : #'Penfeld-Tests-Components'
}

{ #category : #private }
PenComponentTest >> setUp [
	status := false.
]

{ #category : #'test - events' }
PenComponentTest >> testHasEvents [

	| c |
	c := PenComponent new.
	self deny: c hasEvents.
	
	c onActionDo: [  ].
	self assert: c hasEvents.
]

{ #category : #test }
PenComponentTest >> testHeight [
	| component |
	component := PenComponent new.
	
	"Height must be nil"
	self assert: component height equals: 0.
	
	component height: 200.
	self assert: component height equals: 200.
	
]

{ #category : #test }
PenComponentTest >> testOnActionPerformOn [
	| c |
	c := PenComponent new.
	c onActionPerform: #toggleStatus on: self.
	self assert: c eventBindings notEmpty.
	
	self deny: status.
	c eventBindings first executeCallback.
	(Delay forMilliseconds: 10) wait. "callback execution is forked"
	self assert: status.
]

{ #category : #'test - events' }
PenComponentTest >> testRemoveAllEvents [

	| c |
	c := PenComponent new.
	
	c onActionDo: [  ].
	self assert: c hasEvents.
	c removeAllEvents.
	self deny: c hasEvents.
	
	c onActionDo: [  ].
	c onClickDo: [  ].
	self assert: c hasEvents.
	c removeAllEvents.
	self deny: c hasEvents.
]

{ #category : #test }
PenComponentTest >> testResizeEvent [
	| component i |
	component := PenComponent new.
	i := 0.
	
	component onResizeDo: [ i := i + 1 ].
	
	component size: 600@400.
	(Delay forMilliseconds: 10) wait. "callback execution is forked"
	self assert: i equals: 1.
	self assert: component size equals: (600@400).
	
	component size: 700@400.
	(Delay forMilliseconds: 10) wait. "callback execution is forked"
	self assert: i equals: 2.
	self assert: component size equals: (700@400).
]

{ #category : #test }
PenComponentTest >> testSize [ 
	| component |
	component := PenComponent new.
	self assert: component size equals: nil.
	
	component size: 200@300.
	self assert: component size x equals: 200.
	self assert: component size y equals: 300.
	
]

{ #category : #test }
PenComponentTest >> testSizeXNil [
	| component |
	component := PenComponent new.
	self assert: component width equals: 0.
	self assert: component height equals: 0.
	
	component height: 200.
	self assert: component height equals: 200.
	self assert: component width equals: 0.
	
]

{ #category : #test }
PenComponentTest >> testSizeYNil [
	| component |
	component := PenComponent new.
	self assert: component width equals: 0.
	self assert: component height equals: 0.
	
	component width: 200.
	self assert: component width equals: 200.
	self assert: component height equals: 0.
	
]

{ #category : #test }
PenComponentTest >> testWidth [
	| component |
	component := PenComponent new.
	
	"Width must be 0"
	self assert: component width equals: 0.
	
	component width: 200.
	self assert: component width equals: 200.
	
]

{ #category : #private }
PenComponentTest >> toggleStatus [
	status := status not.
]
