Class {
	#name : #PenBlocTreeTableNodeDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'iconPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> doAfterApplyStyleOn: aComponent [
	aComponent tree sections do: [ :section | 
		| selector content fixedSize |
		selector := section selector.
		fixedSize := section size.
		content := aComponent atSection: selector.
		content engineElement constraintsDo: [ :c | 
			fixedSize isNumber ifTrue: [ c horizontal exact: fixedSize ].
			fixedSize = #maximized ifTrue: [ c horizontal matchParent ]
		].
	].
]

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> doBeforeApplyStyleOn: aComponent [
	| points icon |
	points := aComponent isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := aComponent engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeTableNodeDresser >> initEngineElementFor: aComponent [
	| treeSection points icon |
	aComponent engineElement: BlElement new.
	aComponent engineElement layout: BlLinearLayout horizontal.
	
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
	].
	
	treeSection := aComponent atSection: aComponent tree treeSectionSelector.
	points := aComponent isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (aComponent isLeaf
		ifTrue: [ Color transparent ]
		ifFalse: [ Color lightGray ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	treeSection engineElement 
		addChildFirst: icon 
		as: #icon.
	treeSection engineElement 
		addChildFirst: (BlElement new size: ((aComponent deepLevel - 1) * 10) @ 1) 
		as: #blank.
	
	aComponent tree sections do: [ :section | 
		| item selector fixedSize |
		selector := section selector.
		fixedSize := section size.
		item := aComponent atSection: selector.
		aComponent engineElement addChild: item engineElement as: selector
	].
	
	iconPushed := false.
	icon := (aComponent engineElement childNamed: aComponent tree treeSectionSelector)
		childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon: aComponent ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon: aComponent ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon: aComponent ].
	
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
PenBlocTreeTableNodeDresser >> whenMouseDownEventOnIcon: aComponent [
	aComponent activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseLeaveEventOnIcon: aComponent [
	iconPushed := false.
	aComponent deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocTreeTableNodeDresser >> whenMouseUpEventOnIcon: aComponent [
	iconPushed ifFalse: [ ^ self ].
	aComponent switchExpand.
	aComponent deactivatePseudoClass: #active.
	iconPushed := false.
]
