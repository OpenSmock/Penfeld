Class {
	#name : #PenDock,
	#superclass : #PenModel,
	#classTraits : 'TPenIndexable classTrait + TPenPositionable classTrait',
	#instVars : [
		'docks'
	],
	#category : #'Penfeld-Core'
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
