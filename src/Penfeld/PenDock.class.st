Class {
	#name : #PenDock,
	#superclass : #PenComponent,
	#instVars : [
		'docks',
		'window'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenDock >> docks [
	^ docks
]

{ #category : #accessing }
PenDock >> docks: anObject [
	docks := anObject
]

{ #category : #testing }
PenDock >> isExternalDock [
	^ false
]

{ #category : #testing }
PenDock >> isViewDock [
	^ false
]

{ #category : #accessing }
PenDock >> refresh [
	self subclassResponsibility 
]

{ #category : #accessing }
PenDock >> window [
	^ window
]

{ #category : #accessing }
PenDock >> window: anObject [
	window := anObject
]
