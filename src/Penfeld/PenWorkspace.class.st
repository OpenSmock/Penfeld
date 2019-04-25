Class {
	#name : #PenWorkspace,
	#superclass : #PenComponent,
	#instVars : [
		'windows'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenWorkspace >> windows [
	^ windows
]

{ #category : #accessing }
PenWorkspace >> windows: anObject [
	windows := anObject
]
