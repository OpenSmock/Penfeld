Class {
	#name : #PenSpaceBuilder,
	#superclass : #PenWindowBuilder,
	#instVars : [
		'space',
		'memento'
	],
	#category : #'Penfeld-Bloc-Space'
}

{ #category : #accessing }
PenSpaceBuilder class >> engine [
	^ PenBlocEngine
]

{ #category : #building }
PenSpaceBuilder >> borderless: aBoolean [
	space borderless: aBoolean
]

{ #category : #building }
PenSpaceBuilder >> buildWindow: aWindow [
	aWindow docks isEmpty ifTrue: [ self error: 'nothing to show' ].
	
	space := BlSpace new
		title: aWindow title;
		position: aWindow position;
		resizable: aWindow isResizable;
		host: (aWindow isMorphic 
			ifTrue: [ self morphicWindowHost ]
			ifFalse: [ aWindow isWorld 
				ifTrue:[ self worldHost ]
				ifFalse:[	 self osWindowHost ]]);
		borderless: aWindow borderless;
		fullscreen: aWindow fullscreen;
		yourself.
	
	aWindow docks do: [ :dock |
		dock isViewDock 
			ifTrue: [ self displayViewDock: dock on: space ]
			ifFalse: [ self displayExternalDock: dock on: space ] ].
	
	aWindow fullscreen 
		ifTrue: [
			space position: 0@0.
			space extent: DisplayScreen actualScreenSize ]
		ifFalse: [ 
			space extent: aWindow getWindowSize ].
		
	space show.
	^ space
]

{ #category : #building }
PenSpaceBuilder >> displayExternalDock: aDock on: aWindow [
	"do nothing yet"
]

{ #category : #building }
PenSpaceBuilder >> displayViewDock: aDock on: aWindow [
	| element |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	aWindow root addChild: (element engineElement relocate: aDock position).
	
	"Save DockView - BlElement association"
	memento at: aDock key put: element engineElement.
]

{ #category : #initialization }
PenSpaceBuilder >> initialize [
	memento := Dictionary new.
]

{ #category : #closing }
PenSpaceBuilder >> isLastOpened: handle [
	| list |
	list := BlSpace allInstances select: [ :e | e isOpened ].
	(list size = 1 and: [ list includes: handle ])
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #closing }
PenSpaceBuilder >> isNoWindowOpened [
	| list |
	list := BlSpace allInstances select: [ :e | e isOpened ].
	list size isEmpty
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #accessing }
PenSpaceBuilder >> morphicWindowHost [
	^BlMorphicWindowHost new
]

{ #category : #closing }
PenSpaceBuilder >> onClosing: handle do: aBlock [
		handle
		addEventHandlerOn: BlSpaceClosedEvent
		do: aBlock
]

{ #category : #closing }
PenSpaceBuilder >> onLastClose: handle do: aBlock [
	handle
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ ((self isLastOpened: handle) or: [ self isNoWindowOpened ])
				ifTrue: aBlock ]
]

{ #category : #accessing }
PenSpaceBuilder >> osWindowHost [
	^BlOSWindowHost default
]

{ #category : #building }
PenSpaceBuilder >> updateViewDock: aDock [
	| element oldElement |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	"Remove previous element"
	oldElement := memento at: aDock key ifAbsent: [ nil ].
	oldElement ifNotNil: [ space root removeChild: oldElement ].
	
	"Add new element"
	space root addChild: (element engineElement relocate: aDock position + element position).
	memento at: aDock key put: element engineElement.
]

{ #category : #accessing }
PenSpaceBuilder >> windowId [
	^ space hostSpace windowId
]

{ #category : #accessing }
PenSpaceBuilder >> worldHost [
	self flag: 'not the best way to find the world instance ...'.
	^ BlMorphicHost new
		containerMorph: WorldMorph allInstances first;
		yourself
]
