Class {
	#name : #PenWindow,
	#superclass : #PenDisplayComponent,
	#instVars : [
		'screenConfiguration',
		'docks',
		'type',
		'title'
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

{ #category : #opening }
PenWindow >> displayExternalDock: aDock [
	self halt: 'to be defined'
]

{ #category : #opening }
PenWindow >> displayViewDock: aDock [
	| element |
	element := aDock view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	self width ifNil: [ 
		element width 
			ifNotNil: [ self width: element width ]
			ifNil: [ self width: self defaultWidth ]
	].
	
	self height ifNil: [ 
		element width 
			ifNotNil: [ self height: element height ]
			ifNil: [ self height: self defaultHeight ]
	].
	
	self engineElement: (BlSpace new
		extent: self width pref @ self height pref;
		title: self title;
		yourself).
	self engineElement root addChild: element engineElement.
	self engineElement show
]

{ #category : #accessing }
PenWindow >> docks [
	^ docks
]

{ #category : #accessing }
PenWindow >> docks: anObject [
	docks := anObject
]

{ #category : #initialization }
PenWindow >> initialize [
	super initialize.
	type := #external.
	docks := OrderedCollection new.
	screenConfiguration := PenScreenConfiguration new
]

{ #category : #testing }
PenWindow >> isMorphic [
	^ type = #morphic
]

{ #category : #accessing }
PenWindow >> morphic [
	type := #morphic
]

{ #category : #opening }
PenWindow >> open [
	"self docks isEmpty ifTrue: [ self error: 'nothing to show' ].
	
	self docks do: [ :dock |
		dock isViewDock 
			ifTrue: [ self displayViewDock: dock ]
			ifFalse: [ self displayExternalDock: dock ] ] "
	| element |
	element := self docks first view displayComponent.
	element isBuilt ifFalse: [ element build ].
	
	self width ifNil: [ 
		element width 
			ifNotNil: [ self width: element width ]
			ifNil: [ self width: 800 asLength ]
	].
	
	self height ifNil: [ 
		element width 
			ifNotNil: [ self height: element height ]
			ifNil: [ self height: 600 asLength ]
	].
		
	self build.
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
PenWindow >> screenConfiguration [
	^ screenConfiguration
]

{ #category : #accessing }
PenWindow >> screenConfiguration: anObject [
	screenConfiguration := anObject
]

{ #category : #accessing }
PenWindow >> styleName [
	^ #window
]

{ #category : #accessing }
PenWindow >> title [
	^ title
]

{ #category : #accessing }
PenWindow >> title: anObject [
	title := anObject
]

{ #category : #initialization }
PenWindow >> withDisplayComponent: anElement [
	| view dock |
	view := PenView with: anElement.
	dock := PenViewDock with: view.
	self docks add: dock.
]
