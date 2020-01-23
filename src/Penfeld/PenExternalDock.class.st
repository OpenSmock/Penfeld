Class {
	#name : #PenExternalDock,
	#superclass : #PenDock,
	#instVars : [
		'externalView'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenExternalDock >> externalView [
	^ externalView
]

{ #category : #accessing }
PenExternalDock >> externalView: anObject [
	externalView := anObject
]

{ #category : #testing }
PenExternalDock >> isExternalDock [
	^ true
]
