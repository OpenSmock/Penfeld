"
I represent a mouse point, used for mouse events (mouse move, mouse down, mouse hover ...)
"
Class {
	#name : #PenMouseEvent,
	#superclass : #PenEvent,
	#instVars : [
		'point',
		'screenPoint'
	],
	#category : #'Penfeld-Events'
}

{ #category : #accessing }
PenMouseEvent >> point [
	^ point
]

{ #category : #accessing }
PenMouseEvent >> point: anObject [
	point := anObject
]

{ #category : #accessing }
PenMouseEvent >> screenPoint [
	^ screenPoint
]

{ #category : #accessing }
PenMouseEvent >> screenPoint: anObject [
	screenPoint := anObject
]
