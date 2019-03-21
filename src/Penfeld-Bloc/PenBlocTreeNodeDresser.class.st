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
	self model engineElement background: aValue
]

{ #category : #dressing }
PenBlocTreeNodeDresser >> doBeforeApplyStyle [
	| points icon |
	points := self model isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := self model engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeNodeDresser >> initEngineElement [
	| points icon |
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout horizontal.
	
	self model engineElement addChild: (BlElement new size: ((self model deepLevel - 1) * 10) @ 1) as: #blank.
	
	points := self model isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (self model hasNodes
		ifTrue: [ Color red ]
		ifFalse: [ Color transparent ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	self model engineElement addChild: icon as: #icon.
	
	self model engineElement addChild: self model content engineElement .
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent].
	
	iconPushed := false.
	icon := self model engineElement childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon ].
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseDownEventOnIcon [
	self model activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseLeaveEventOnIcon [
	iconPushed := false.
	self model deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseUpEventOnIcon [
	iconPushed ifTrue: [ ^ self ].
	self model deactivatePseudoClass: #active.
	iconPushed := false.
]
