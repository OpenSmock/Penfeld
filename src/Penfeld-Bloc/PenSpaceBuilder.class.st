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
PenSpaceBuilder >> buildWindow: aWindow [
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
PenSpaceBuilder >> displayExternalDock: aDock on: aWindow [
	self halt: 'to be defined'
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

{ #category : #building }
PenSpaceBuilder >> updateViewDock: aDock [
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
