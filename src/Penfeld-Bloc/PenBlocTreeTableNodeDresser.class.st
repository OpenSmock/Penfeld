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
PenBlocTreeTableNodeDresser >> doAfterApplyStyle [ 
	self component tree sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := self component atSection: selector.
		content engineElement constraintsDo: [ :c | 
			fixedSize isNumber ifTrue: [ c horizontal exact: fixedSize ].
			fixedSize = #maximized ifTrue: [ c horizontal matchParent ]
		].
	].
]

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> doBeforeApplyStyle [
	| points icon |
	points := self component isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := self component engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> initEngineElement [
	| treeSection points icon |
	self component engineElement: BlElement new.
	self component engineElement layout: BlLinearLayout horizontal.
	
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
	].
	
	treeSection := self component atSection: self component tree treeSectionSelector.
	points := self component isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (self component isLeaf
		ifTrue: [ Color transparent ]
		ifFalse: [ Color lightGray ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	treeSection engineElement 
		addChildFirst: icon 
		as: #icon.
	treeSection engineElement 
		addChildFirst: (BlElement new size: ((self component deepLevel - 1) * 10) @ 1) 
		as: #blank.
	
	self component tree sections do: [ :section | 
		| item selector fixedSize |
		selector := section selector.
		fixedSize := section size.
		item := self component atSection: selector.
		self component engineElement addChild: item engineElement as: selector
	].
	
	iconPushed := false.
	icon := (self component engineElement childNamed: self component tree treeSectionSelector)
		childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon ].
	
]

{ #category : #styling }
PenBlocTreeTableNodeDresser >> sectionsOrderChanged: aComponent [
	| temp |
	temp := Dictionary new.
	aComponent tree sections do: [ :section | | selector |
		selector := section selector.
		temp at: selector put: (aComponent engineElement childNamed: selector).
		aComponent engineElement removeChildNamed: selector ].
	aComponent tree sections do: [ :section |
		aComponent engineElement addChild: (temp at: section selector) ]
]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseDownEventOnIcon [
	self component activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseLeaveEventOnIcon [
	iconPushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseUpEventOnIcon [
	iconPushed ifFalse: [ ^ self ].
	self component switchExpand.
	self component deactivatePseudoClass: #active.
	iconPushed := false.
]
