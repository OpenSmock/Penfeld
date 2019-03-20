Class {
	#name : #PenDBlocTreeNode,
	#superclass : #PenBlocDresser,
	#instVars : [
		'iconPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocTreeNode class >> styleSelector [
	^ #treeNode
]

{ #category : #initialization }
PenDBlocTreeNode >> applyStyle: aStyle [
	| background |
	background := self getBackground: aStyle.
	background ifNotNil: [ self model interactor background: background ].
]

{ #category : #rendering }
PenDBlocTreeNode >> doBeforeApplyStyle [
	| points icon |
	points := self model isExpanded
		ifTrue: [ { 0@0. 8@0. 4@6 } ]
		ifFalse: [ { 0@0. 6@4. 0@8 } ].
	icon := self model interactor childNamed: #icon.
	icon geometry: (BlPolygon vertices: points).
]

{ #category : #initialization }
PenDBlocTreeNode >> initInteractor [
	| points icon |
	self model interactor: BlElement new.
	self model interactor layout: BlLinearLayout horizontal.
	
	self model interactor addChild: (BlElement new size: ((self model deepLevel - 1) * 10) @ 1) as: #blank.
	
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
	self model interactor addChild: icon as: #icon.
	
	self model interactor addChild: self model content interactor .
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent].
	
	iconPushed := false.
	icon := self model interactor childNamed: #icon.
	icon when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOnIcon ].
	icon when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOnIcon ].
	icon when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOnIcon ].
]

{ #category : #events }
PenDBlocTreeNode >> whenMouseDownEventOnIcon [
	self model setActiveStyles.
	iconPushed := true.

]

{ #category : #events }
PenDBlocTreeNode >> whenMouseLeaveEventOnIcon [
	iconPushed := false.
	self model resetStyles.
]

{ #category : #events }
PenDBlocTreeNode >> whenMouseUpEventOnIcon [
	iconPushed ifTrue: [ ^ self ].
	self model resetStyles.
	iconPushed := false.
]
