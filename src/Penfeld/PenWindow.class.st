Class {
	#name : #PenWindow,
	#superclass : #PenComponent,
	#instVars : [
		'screenConfiguration',
		'docks',
		'type',
		'title',
		'resizable',
		'borderless',
		'fullscreen',
		'opened',
		'builder',
		'handle',
		'process'
	],
	#classVars : [
		'EngineClass'
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

{ #category : #wizard }
PenWindow class >> withView: aView [
	^ self new 
		withView: aView;
		yourself
]

{ #category : #accessing }
PenWindow >> addDock: aDock [
	self docks add: aDock.
	aDock window: self.
]

{ #category : #accessing }
PenWindow >> borderless [
	^ borderless
]

{ #category : #accessing }
PenWindow >> borderless: aBoolean [
	borderless := aBoolean
]

{ #category : #opening }
PenWindow >> close [
	self flag: 'never called'.
	process terminate
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
PenWindow >> fullscreen [
	^ fullscreen
]

{ #category : #accessing }
PenWindow >> fullscreen: aBoolean [
	fullscreen := aBoolean
]

{ #category : #accessing }
PenWindow >> getDock: aKey [
	^ self docks detect: [ :d | d key = aKey ] ifNone: [ nil ]
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
	self flag: 'TODO: calulate size of all docks'.
	
	"Width and height"
	width := self width 
		ifNil: [ element width 
			ifNotNil: [ element width ]
			ifNil: [ self defaultWidth ] ]
		ifNotNil: [ self width ].
	
	height := self height 
		ifNil: [ element height 
			ifNotNil: [ element height ]
			ifNil: [ self defaultHeight ] ]
		ifNotNil: [ self height ].
	
	^ width pref @ height pref
]

{ #category : #accessing }
PenWindow >> handle [
	^ handle
]

{ #category : #accessing }
PenWindow >> handle: anObject [
	handle := anObject
]

{ #category : #accessing }
PenWindow >> id [
	^ builder windowId
]

{ #category : #initialization }
PenWindow >> initialize [
	super initialize.
	type := #external.
	docks := OrderedCollection new.
	screenConfiguration := PenScreenConfiguration new.
	resizable := true.
	borderless := false.
	fullscreen := false.
	opened := false.
	self initializeBuilder
]

{ #category : #initialization }
PenWindow >> initializeBuilder [
	| builderClass |
	builderClass := PenWindowBuilder forEngine: PenEngine default class.
	builderClass
		ifNil: [ PenEngineNotFoundException new
				signal: 'Cannot find builder for engine' ].
	builder := builderClass new
]

{ #category : #testing }
PenWindow >> isMorphic [
	^ type = #morphic
]

{ #category : #testing }
PenWindow >> isOpened [
	^ opened
]

{ #category : #testing }
PenWindow >> isResizable [
	^ resizable
]

{ #category : #testing }
PenWindow >> isWindow [
	^ type = #window
]

{ #category : #testing }
PenWindow >> isWorld [
	^ type = #world
]

{ #category : #opening }
PenWindow >> open [
	handle := builder buildWindow: self.
	opened := true.
	process := [ [ 
			self docks do: [ :aDock | aDock refresh ]. 
			20 milliSeconds wait ] 
		repeat ] fork.
]

{ #category : #opening }
PenWindow >> openInMorphic [
	self useMorphic.
	self open 
]

{ #category : #opening }
PenWindow >> openInWindow [
	self useWindow.
	self open 
]

{ #category : #opening }
PenWindow >> openInWorld [
	self useMorphic.
	self open
]

{ #category : #closing }
PenWindow >> quitImage [
	Smalltalk snapshot: false andQuit: true
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

{ #category : #building }
PenWindow >> updateViewDock: aViewDock [
	self isOpened ifFalse: [ ^ self ].
	builder updateViewDock: aViewDock
]

{ #category : #accessing }
PenWindow >> useMorphic [
	type := #morphic
]

{ #category : #accessing }
PenWindow >> useWindow [
	type := #window
]

{ #category : #accessing }
PenWindow >> useWorld [
	type := #world
]

{ #category : #wizard }
PenWindow >> withDisplayComponent: anElement [
	| view dock |
	view := PenView with: anElement.
	dock := PenViewDock with: view.
	self docks add: dock.
]

{ #category : #wizard }
PenWindow >> withView: aView [
	| dock |
	dock := PenViewDock with: aView.
	self docks add: dock.
]
