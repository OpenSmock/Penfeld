Class {
	#name : #PenBlocTreeNodeDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'iconPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocTreeNodeDresser >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #dressing }
PenBlocTreeNodeDresser >> doBeforeApplyStyle [
	| points icon |
	points := self component isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := self component engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeNodeDresser >> initEngineElement [
	| points icon |
	self component engineElement: BlElement new.
	self component engineElement layout: BlLinearLayout horizontal.
	
	self component engineElement addChild: (BlElement new size: ((self component deepLevel - 1) * 10) @ 1) as: #blank.
	
	points := self component isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (self component hasNodes
		ifTrue: [ Color red ]
		ifFalse: [ Color transparent ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	self component engineElement addChild: icon as: #icon.
	
	self component engineElement addChild: self component content engineElement .
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent].
	
	iconPushed := false.
	icon := self component engineElement childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon ].
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseDownEventOnIcon [
	self component activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseLeaveEventOnIcon [
	iconPushed := false.
	self component deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseUpEventOnIcon [
	iconPushed ifTrue: [ ^ self ].
	self component switchExpand.
	self component deactivatePseudoClass: #active.
	iconPushed := false.
]
