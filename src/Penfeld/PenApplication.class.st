Class {
	#name : #PenApplication,
	#superclass : #PenModel,
	#instVars : [
		'workspaces'
	],
	#category : #'Penfeld-Core'
}

{ #category : #accessing }
PenApplication >> workspaces [
	^ workspaces
]

{ #category : #accessing }
PenApplication >> workspaces: anObject [
	workspaces := anObject
]
