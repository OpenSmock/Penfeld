Class {
	#name : #PenSpaceHelper,
	#superclass : #PenWindowHelper,
	#instVars : [
		'space',
		'memento'
	],
	#category : #'Penfeld-Bloc-Space'
}

{ #category : #accessing }
PenSpaceHelper class >> engine [
	^ PenBlocEngine
]

{ #category : #building }
PenSpaceHelper >> buildWindow: aWindow [
	aWindow docks isEmpty ifTrue: [ self error: 'nothing to show' ].
	
	space := BlSpace new
		title: aWindow title;
		resizable: aWindow isResizable;
		yourself.
	
	aWindow docks do: [ :dock |
		dock isViewDock 
			ifTrue: [ self displayViewDock: dock on: space ]
			ifFalse: [ self displayExternalDock: dock on: space ] ].
		
	space extent: aWindow getWindowSize.
	space show.
]

{ #category : #building }
PenSpaceHelper >> displayExternalDock: aDock on: aWindow [
	"do nothing yet"
]

{ #category : #building }
PenSpaceHelper >> displayViewDock: aDock on: aWindow [
	| element |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	aWindow root addChild: (element engineElement relocate: aDock position).
	
	"Save DockView - BlElement association"
	memento at: aDock key put: element engineElement.
]

{ #category : #initialization }
PenSpaceHelper >> initialize [
	memento := Dictionary new.
]

{ #category : #building }
PenSpaceHelper >> updateViewDock: aDock [
	| element oldElement |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	"Remove previous element"
	oldElement := memento at: aDock key ifAbsent: [ nil ].
	oldElement ifNotNil: [ space root removeChild: oldElement ].
	
	"Add new element"
	space root addChild: (element engineElement relocate: aDock position).
	memento at: aDock key put: element engineElement.
]
