Class {
	#name : #PenBlocTreeTableNodeDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait',
	#instVars : [
		'iconPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> doBeforeApplyStyle [
	| points icon |
	points := self model isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := self model engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> initEngineElement [
	| treeSection points icon |
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout horizontal.
	
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		self flag: 'ideally: c vertical fitContent'.
		c vertical exact: 20. ].
	
	treeSection := self model atSection: self model tree treeSectionSelector.
	points := self model isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (self model isLeaf
		ifTrue: [ Color transparent ]
		ifFalse: [ Color lightGray ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	treeSection engineElement 
		addChildFirst: icon 
		as: #icon.
	treeSection engineElement 
		addChildFirst: (BlElement new size: ((self model deepLevel - 1) * 10) @ 1) 
		as: #blank.
	
	self model tree sections do: [ :section | 
		| item selector fixedSize |
		selector := section selector.
		fixedSize := section size.
		item := self model atSection: selector.
		fixedSize ifNotNil: [ item engineElement constraintsDo: [ :c | c horizontal exact: fixedSize ]].
		self model engineElement addChild: item engineElement as: selector].
	
	iconPushed := false.
	icon := (self model engineElement childNamed: self model tree treeSectionSelector)
		childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon ].
	
]

{ #category : #styling }
PenBlocTreeTableNodeDresser >> sectionsOrderChanged: aModel [
	| temp |
	temp := Dictionary new.
	aModel tree sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aModel engineElement childNamed: selector).
		aModel engineElement removeChildNamed: selector ].
	aModel tree sections do: [ :section |
		aModel engineElement addChild: (temp at: section selector) ]
]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseDownEventOnIcon [
	self model activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseLeaveEventOnIcon [
	iconPushed := false.
	self model resetStyles.
]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseUpEventOnIcon [
	iconPushed ifFalse: [ ^ self ].
	self model resetStyles.
	iconPushed := false.
]
