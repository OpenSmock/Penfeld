Class {
	#name : #PenBlocImageDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'form',
		'maxWidth',
		'maxHeight'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocImageDresser >> color: aValue [
	form := form repaintWith: aValue value.
]

{ #category : #dressing }
PenBlocImageDresser >> doAfterApplyStyle [ 
	| element width height position x y |
	
	element := self component engineElement.
	
	form ifNil: [ ^ self ].

	"Size"
	width := self component width ifNotNil: [ self component width pref ].
	width ifNil: [ width := form width ].
	height := self component height ifNotNil: [ self component height pref ].
	height ifNil: [ height := form height ].
	form := form scaledToSize: width @ height.
	
	"Center image in shape"
	x := (width - form width) / 2.
	y := (height - form height) / 2.
	(element childNamed: #image) 
		background: form asBlBackground;
		size: form width @ form height;
		relocate: x @ y.
	
	"Position"
	position := self component position.
	position ifNotNil: [ element relocate: position ].	
	
	element constraintsDo: [ :c | 
		c horizontal exact: width.
		c vertical exact: height ].	
]

{ #category : #dressing }
PenBlocImageDresser >> doBeforeApplyStyle [ 
	form := self component form copy.
]

{ #category : #dressing }
PenBlocImageDresser >> initEngineElement [
	self component engineElement: (BlElement new addChild: BlElement new as: #image).
	self component hasEvents ifFalse: [ self component engineElement preventMeAndChildrenMouseEvents ].
]

{ #category : #styling }
PenBlocImageDresser >> maxHeight: aValue [
	maxHeight := aValue value.
]

{ #category : #styling }
PenBlocImageDresser >> maxWidth: aValue [
	maxWidth := aValue value.
]
