Class {
	#name : #PenView,
	#superclass : #PenComponent,
	#instVars : [
		'dock',
		'displayComponent'
	],
	#category : #'Penfeld-Components'
}

{ #category : #'instance creation' }
PenView class >> with: anElement [
	^ (self key: #view) 
		displayComponent: anElement;
		yourself
]

{ #category : #accessing }
PenView >> displayComponent [
	^ displayComponent
]

{ #category : #accessing }
PenView >> displayComponent: anObject [
	displayComponent := anObject
]

{ #category : #accessing }
PenView >> dock [
	^ dock
]

{ #category : #accessing }
PenView >> dock: anObject [
	dock := anObject
]

{ #category : #opening }
PenView >> openInWorld [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInWorld.
]
