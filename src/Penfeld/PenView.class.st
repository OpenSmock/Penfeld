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
	displayComponent := anObject.
	anObject addStyleClass: #root.
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
PenView >> openInMorphic [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInMorphic.
]

{ #category : #opening }
PenView >> openInMorphicWindow [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInWindow.
]

{ #category : #opening }
PenView >> openInWindow [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInWindow.
]

{ #category : #opening }
PenView >> openInWorld [
	dock ifNil: [ dock := PenViewDock with: self ].
	dock openInWorld.
]

{ #category : #accessing }
PenView >> refresh [
	self displayComponent loopRefresh
]
