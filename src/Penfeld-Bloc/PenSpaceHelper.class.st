Class {
	#name : #PenSpaceHelper,
	#superclass : #PenWindowHelper,
	#category : #'Penfeld-Bloc-Space'
}

{ #category : #accessing }
PenSpaceHelper class >> engine [
	^ PenBlocEngine
]

{ #category : #building }
PenSpaceHelper >> buildWindow: aWindow [
	| space |
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
	self halt: 'to be defined'
]

{ #category : #building }
PenSpaceHelper >> displayViewDock: aDock on: aWindow [
	| element |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	aWindow root addChild: (element engineElement relocate: aDock position).
]
