Class {
	#name : #PenWindow,
	#superclass : #PenComponent,
	#instVars : [
		'screenConfiguration',
		'docks',
		'type',
		'title',
		'resizable'
	],
	#category : #'Penfeld-Components'
}

{ #category : #wizard }
PenWindow class >> withDisplayComponent: anElement [
	^ self new 
		withDisplayComponent: anElement;
		yourself
]

{ #category : #wizard }
PenWindow class >> withDock: aDock [
	^ self new 
		addDock: aDock;
		yourself
]

{ #category : #accessing }
PenWindow >> addDock: aDock [
	self docks add: aDock
]

{ #category : #opening }
PenWindow >> close [
	self engineElement close
]

{ #category : #defaults }
PenWindow >> defaultHeight [
	^ 600 asLength
]

{ #category : #defaults }
PenWindow >> defaultWidth [ 
	^ 800 asLength
]

{ #category : #accessing }
PenWindow >> docks [
	^ docks
]

{ #category : #accessing }
PenWindow >> docks: anObject [
	docks := anObject
]

{ #category : #accessing }
PenWindow >> getView: aKey [
	^ self docks 
		detect: [ :d |
			d view 
				ifNil: [ false ]
				ifNotNil: [ d view key = aKey ] ] 
		ifFound: [ :d | d view ]
		ifNone: [ nil ]
]

{ #category : #opening }
PenWindow >> getWindowSize [
	| width height element |
	element := self docks first view displayComponent.
	self flag: 'calulate size of all docks'.
	
	"Width and height"
	width := self width 
		ifNil: [ element width 
			ifNotNil: [ element width ]
			ifNil: [ 800 asLength ] ]
		ifNotNil: [ self width ].
	
	height := self height 
		ifNil: [ element height 
			ifNotNil: [ element height ]
			ifNil: [ 600 asLength ] ]
		ifNotNil: [ self height ].
	
	^ width pref @ height pref
]

{ #category : #initialization }
PenWindow >> initialize [
	super initialize.
	type := #external.
	docks := OrderedCollection new.
	screenConfiguration := PenScreenConfiguration new.
	resizable := true.
]

{ #category : #testing }
PenWindow >> isMorphic [
	^ type = #morphic
]

{ #category : #testing }
PenWindow >> isResizable [
	^ resizable
]

{ #category : #accessing }
PenWindow >> morphic [
	type := #morphic
]

{ #category : #opening }
PenWindow >> open [
	| engine helper |
	self flag: #toImprove.
	engine := PenEngine default.
	
	helper := PenWindowHelper forEngine: engine class.
	helper 
		ifNil: [ self inform: 'Can not find a window helper for engine: ', engine printString. ] 
		ifNotNil: [ helper new buildWindow: self ].
]

{ #category : #opening }
PenWindow >> openInWindow [
	^ self notYetImplemented 
]

{ #category : #opening }
PenWindow >> openInWorld [
	self morphic.
	self open
]

{ #category : #accessing }
PenWindow >> resizable: anObject [
	resizable := anObject
]

{ #category : #accessing }
PenWindow >> screenConfiguration [
	^ screenConfiguration
]

{ #category : #accessing }
PenWindow >> screenConfiguration: anObject [
	screenConfiguration := anObject
]

{ #category : #accessing }
PenWindow >> title [
	^ title
]

{ #category : #accessing }
PenWindow >> title: aString [
	title := aString
]

{ #category : #initialization }
PenWindow >> withDisplayComponent: anElement [
	| view dock |
	view := PenView with: anElement.
	dock := PenViewDock with: view.
	self docks add: dock.
]
