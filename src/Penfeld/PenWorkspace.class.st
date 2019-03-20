Class {
	#name : #PenWorkspace,
	#superclass : #PenModel,
	#instVars : [
		'windows'
	],
	#category : #'Penfeld-Core'
}

{ #category : #accessing }
PenWorkspace >> windows [
	^ windows
]

{ #category : #accessing }
PenWorkspace >> windows: anObject [
	windows := anObject
]
