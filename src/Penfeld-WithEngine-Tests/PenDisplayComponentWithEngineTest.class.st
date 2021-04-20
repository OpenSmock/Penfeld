Class {
	#name : #PenDisplayComponentWithEngineTest,
	#superclass : #PenDisplayComponentTest,
	#category : #'Penfeld-WithEngine-Tests-Tests'
}

{ #category : #'as yet unclassified' }
PenDisplayComponentWithEngineTest >> testBuildStyle [
	| button |
	button := PenButton new
		stylesheet: PenDefaultStylesheet dark;
		addCustomStyle: (PssBackgroundModel new color: (PssColorValue value: Color white));
		build.
	
	"Button background color in PenStylesheet dark is #323232"
	self assert: (button getStyle: #background) color equals: Color white. 
]

{ #category : #'as yet unclassified' }
PenDisplayComponentWithEngineTest >> testBuildWithIndex [
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

{ #category : #'as yet unclassified' }
PenDisplayComponentWithEngineTest >> testChooseStylesheet [
	| container button stylesheet |
	stylesheet := PssStylesheet new.
	button := PenButton new.
	container := PenContainer new.
	container stylesheet: stylesheet.
	container addElement: button.
	container build.
	
	self assert: button stylesheet == stylesheet 
]
