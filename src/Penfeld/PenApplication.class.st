Class {
	#name : #PenApplication,
	#superclass : #PenComponent,
	#instVars : [
		'workspaces'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenApplication >> workspaces [
	^ workspaces
]

{ #category : #accessing }
PenApplication >> workspaces: anObject [
	workspaces := anObject
]
