"
A PFNodeTest is a test class for testing the behavior of PFNode
"
Class {
	#name : #PenDisplayComponentTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Components'
}

{ #category : #'tests-private' }
PenDisplayComponentTest >> testAddAllCallbackFor [
	| node symbols binding |
	node := PenDisplayComponent new.
	symbols := Array 
		with: PenEventSymbol mouseHover 
		with: PenEventSymbol mouseUp.

	node onEvents: symbols do: [ self inform: 'Custom declaration' ].
	self assert: node eventBindings size equals: 1.
	
	binding := node eventBindings first.
	self assert: (binding symbols includesAll: symbols).
]

{ #category : #'tests-private' }
PenDisplayComponentTest >> testAddCallbackFor [
	| node binding |
	node := PenInteractionElement new.
	self assert: node eventBindings isEmpty.
	
	"Add a first callback"
	node onClickDo: [ self inform: 'Click' ].
	self assert: node eventBindings size equals: 1.
	binding := node eventBindings first.
	self assert: binding symbol equals: PenEventSymbol click.
	
	"Add a second callback on same event"
	node onClickDo: [ self inform: 'Click2' ].
	self assert: node eventBindings size equals: 2.
	binding := node eventBindings second.
	self assert: binding symbol equals: PenEventSymbol click.
	
	"Add an other callback"
	node onMouseDownDo: [ self inform: 'MouseDown' ].
	self assert: node eventBindings size equals: 3.
	binding := node eventBindings third.
	self assert: binding symbol equals: PenEventSymbol mouseDown.
]

{ #category : #'tests-private' }
PenDisplayComponentTest >> testBuildStyle [
	| button |
	button := PenButton new
		stylesheet: PenDefaultStylesheet dark;
		addCustomStyle: (PssBackgroundModel new color: (PssColorValue value: Color white));
		build.
	
	"Button background color in PenStylesheet dark is #323232"
	self assert: (button getStyle: #background) color equals: Color white. 
]

{ #category : #'tests-private' }
PenDisplayComponentTest >> testBuildWithIndex [
	| container item1 item2 item3 |
	
	item1 := PenButton new.
	item2 := PenLabel new.
	item3 := PenLabel new.
	container := PenContainer new addAllElements: { item1. item2. item3 }.	
	container build.
	
	self assert: item1 pseudoClasses size equals: 2.
	self assert: item2 pseudoClasses size equals: 2.
	self assert: item3 pseudoClasses size equals: 2.
	
	self assert: (item1 pseudoClasses includes: (#nthChild -> 1)).
	self assert: (item1 pseudoClasses includes: (#nthChild -> #odd)).
	
	self assert: (item2 pseudoClasses includes: (#nthChild -> 2)).
	self assert: (item2 pseudoClasses includes: (#nthChild -> #even)).
	
	self assert: (item3 pseudoClasses includes: (#nthChild -> 3)).
	self assert: (item3 pseudoClasses includes: (#nthChild -> #odd)).
]

{ #category : #'tests-private' }
PenDisplayComponentTest >> testChooseStylesheet [
	| container button stylesheet |
	stylesheet := PssStylesheet new.
	button := PenButton new.
	container := PenContainer new.
	container stylesheet: stylesheet.
	container addElement: button.
	container build.
	
	self assert: button stylesheet == stylesheet 
]

{ #category : #test }
PenDisplayComponentTest >> testHeight [
	| cmp |
	cmp := PenDisplayComponent new.
	cmp height: 120.
	self assert: cmp height equals: 120.

]

{ #category : #test }
PenDisplayComponentTest >> testSize [
	| cmp |
	"Normal case"
	cmp := PenDisplayComponent new.
	cmp size: 120 @ 130.
	self assert: cmp width equals: 120.
	self assert: cmp height equals: 130.
	self assert: cmp size equals: 120 @ 130.
	
	"Height is not specified"
	cmp := PenDisplayComponent new.
	cmp width: 120.
	self assert: cmp width equals: 120.
	self assert: cmp height equals: nil.
	self assert: cmp size equals: nil.
	
	"Width is not specified"
	cmp := PenDisplayComponent new.
	cmp height: 130.
	self assert: cmp width equals: nil.
	self assert: cmp height equals: 130.
	self assert: cmp size equals: nil.
]

{ #category : #test }
PenDisplayComponentTest >> testWidth [
	| cmp |
	cmp := PenDisplayComponent new.
	cmp width: 130.
	self assert: cmp width equals: 130.
]
