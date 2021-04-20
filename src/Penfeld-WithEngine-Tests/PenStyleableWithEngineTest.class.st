Class {
	#name : #PenStyleableWithEngineTest,
	#superclass : #PenStyleableTest,
	#category : #'Penfeld-WithEngine-Tests-Tests'
}

{ #category : #tests }
PenStyleableWithEngineTest >> testStyleablePseudoClassWithArg [
	| stylesheet table item1 item2 rules |
	stylesheet := self stylesheet1.
	
	table := PenTable new.
	item1 := PenTableItem new.
	item2 := PenTableItem new.
	table addAllItems: { item1. item2. }.
	table build.
	
	rules := stylesheet matchingRulesFor: item2.
	self assert: rules size equals: 2.
	self assert: (rules second selector pseudoClasses includesKey: #nthChild).
]

{ #category : #tests }
PenStyleableWithEngineTest >> testStyleablePseudoClassWithArgSymbol [
	| stylesheet table item1 item2 rules |
	stylesheet := self stylesheet1.
	
	table := PenTable new.
	item1 := PenTableItem new.
	item2 := PenTableItem new.
	table addAllItems: { item1. item2. }.
	table build.
	
	rules := stylesheet matchingRulesFor: item1.
	self assert: rules size equals: 2.
	self assert: (rules second selector pseudoClasses includesKey: #nthChild).
]
