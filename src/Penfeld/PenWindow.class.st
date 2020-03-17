Class {
	#name : #PenWindow,
	#superclass : #PenComponent,
	#instVars : [
		'screenConfiguration',
		'views',
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

{ #category : #opening }
PenWindow class >> openInMorphicWindow: aView [
	^ self new 
		addView: aView;
		openInMorphicWindow;
		yourself
]

{ #category : #opening }
PenWindow class >> openInWindow: aView [
	^ self new 
		addView: aView;
		openInWindow;
		yourself
]

{ #category : #opening }
PenWindow class >> openInWorld: aView [
	^ self new 
		addView: aView;
		openInWorld;
		yourself
]

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
PenWindow >> addView: aView [
	self views add: aView.
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
	^ self views detect: [ :d | d key = aKey ] ifNone: [ nil ]
]

{ #category : #opening }
PenWindow >> getWindowSize [
	| width height element |
	element := self views first displayComponent.
	
	"Width"
	width := self width.
	width ifNil:[
		element 
			ifNil:[width := self defaultWidth]
			ifNotNil:[width := (element width ifNotNil: [ element width ] ifNil: [ self defaultWidth ])].
	].

	"Height"
	height := self height.
	height ifNil:[
		element 
			ifNil:[height := self defaultHeight]
			ifNotNil:[height := (element height ifNotNil: [ element height ] ifNil: [ self defaultHeight ])].
	].
	
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
	views := OrderedCollection new.
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

{ #category : #closing }
PenWindow >> onCloseExecute: aBlock [
	builder ifNil: [ self error: 'Nil builder !' ].
	builder onClosing: handle do: aBlock
]

{ #category : #closing }
PenWindow >> onCloseQuit [
	^self onCloseExecute: [ self quitImage ].
]

{ #category : #closing }
PenWindow >> onLastCloseExecute: aBlock [
	builder ifNil: [ self error: 'Nil builder !' ].
	builder onLastClose: handle do: aBlock
]

{ #category : #closing }
PenWindow >> onLastCloseQuit [
	^self onLastCloseExecute: [ self quitImage ]
]

{ #category : #opening }
PenWindow >> open [
	handle := builder buildWindow: self.
	opened := true.
	process := [ [ 
			self views do: [ :aView | aView refresh ]. 
			20 milliSeconds wait ] 
		repeat ] fork.
]

{ #category : #opening }
PenWindow >> openInMorphic [
	self useMorphic.
	self open 
]

{ #category : #opening }
PenWindow >> openInMorphicWindow [
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
	self useWorld.
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
PenWindow >> updateView: aKey [
	| view |
	self flag: 'utility ?'.
	self isOpened ifFalse: [ ^ self ].
	view := self getView: aKey.
	builder updateView: view
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

{ #category : #accessing }
PenWindow >> views [
	^ views
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
