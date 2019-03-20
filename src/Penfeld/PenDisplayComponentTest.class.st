"
A PFNodeTest is a test class for testing the behavior of PFNode
"
Class {
	#name : #PenDisplayComponentTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests'
}

{ #category : #'tests-private' }
PenDisplayComponentTest >> testAddAllCallbackFor [
	| node symbols binding |
	node := PenDisplayComponent new.
	symbols := Array 
		with: PenEventSymbol mouseHover 
		with: PenEventSymbol mouseUp.

	node on: symbols do: [ self inform: 'Custom declaration' ].
	self assert: node callbacks size equals: 1.
	
	binding := node callbacks first.
	self assert: (binding symbols includesAll: symbols).
]

{ #category : #'tests-private' }
PenDisplayComponentTest >> testAddCallbackFor [
	| node binding |
	node := PenInteractionElement new.
	self assert: node callbacks isEmpty.
	
	"Add a first callback"
	node onClickDo: [ self inform: 'Click' ].
	self assert: node callbacks size equals: 1.
	binding := node callbacks first.
	self assert: binding symbol equals: PenEventSymbol click.
	
	"Add a second callback on same event"
	node onClickDo: [ self inform: 'Click2' ].
	self assert: node callbacks size equals: 2.
	binding := node callbacks second.
	self assert: binding symbol equals: PenEventSymbol click.
	
	"Add an other callback"
	node onMouseDownDo: [ self inform: 'MouseDown' ].
	self assert: node callbacks size equals: 3.
	binding := node callbacks third.
	self assert: binding symbol equals: PenEventSymbol mouseDown.
]
