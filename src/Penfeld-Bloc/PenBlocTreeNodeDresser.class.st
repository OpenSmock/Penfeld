Class {
	#name : #PenBlocTreeNodeDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'iconPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocTreeNodeDresser >> doBeforeApplyStyleOn: aComponent [
	| points icon |
	points := aComponent isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := aComponent engineElement childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #dressing }
PenBlocTreeNodeDresser >> initEngineElementFor: aComponent [
	| points icon |
	aComponent engineElement: BlElement new.
	aComponent engineElement layout: BlLinearLayout horizontal.
	
	aComponent engineElement addChild: (BlElement new size: ((aComponent deepLevel - 1) * 10) @ 1) as: #blank.
	
	points := aComponent isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := (BlPolygon vertices: points) asElement.
	icon background: (aComponent hasNodes
		ifTrue: [ Color red ]
		ifFalse: [ Color transparent ]).
	icon border: BlBorder empty.
	icon margin: (BlInsets all: 3).
	icon constraintsDo: [ :c | c linear vertical alignCenter ].
	aComponent engineElement addChild: icon as: #icon.
	
	aComponent engineElement addChild: aComponent content engineElement .
	aComponent engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent].
	
	iconPushed := false.
	icon := aComponent engineElement childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon: aComponent ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon: aComponent ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon: aComponent ].
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseDownEventOnIcon: aComponent [
	aComponent activatePseudoClass: #active.
	iconPushed := true.

]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseLeaveEventOnIcon: aComponent [
	iconPushed := false.
	aComponent deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocTreeNodeDresser >> whenMouseUpEventOnIcon: aComponent [
	iconPushed ifTrue: [ ^ self ].
	aComponent switchExpand.
	aComponent deactivatePseudoClass: #active.
	iconPushed := false.
]
