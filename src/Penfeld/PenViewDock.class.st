Class {
	#name : #PenViewDock,
	#superclass : #PenDock,
	#instVars : [
		'view'
	],
	#category : #'Penfeld-Components'
}

{ #category : #'instance creation' }
PenViewDock class >> with: aView [
	^ self new
		view: aView;
		yourself
]

{ #category : #testing }
PenViewDock >> isViewDock [
	^ true
]

{ #category : #opening }
PenViewDock >> openInMorphic [
	window := PenWindow withDock: self.
	window useMorphic.
	window open
]

{ #category : #opening }
PenViewDock >> openInMorphicWindow [
	
	window := PenWindow withDock: self.
	window useMorphic.
	window open
]

{ #category : #opening }
PenViewDock >> openInWindow [
	window := PenWindow withDock: self.
	window open
]

{ #category : #opening }
PenViewDock >> openInWorld [
	window := PenWindow withDock: self.
	window useWorld.
	window open
]

{ #category : #accessing }
PenViewDock >> refresh [ 
	self view refresh
]

{ #category : #accessing }
PenViewDock >> view [
	^ view
]

{ #category : #accessing }
PenViewDock >> view: aView [
	view := aView.
	self window ifNotNil: [ self window updateViewDock: self ].
]
