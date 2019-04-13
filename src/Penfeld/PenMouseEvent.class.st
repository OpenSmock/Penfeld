"
I represent a mouse point, used for mouse events (mouse move, mouse down, mouse hover ...)
"
Class {
	#name : #PenMouseEvent,
	#superclass : #PenEvent,
	#instVars : [
		'point'
	],
	#category : #'Penfeld-Events'
}

{ #category : #'instance creation' }
PenMouseEvent class >> fromBloc: anBlocEvent [
	self flag: 'mouve it in bloc package'.
	^ self new
]
