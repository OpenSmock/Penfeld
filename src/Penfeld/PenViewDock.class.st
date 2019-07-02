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
PenViewDock >> openInWorld [
	| window |
	window := PenWindow withDock: self.
	window morphic.
	window open
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
