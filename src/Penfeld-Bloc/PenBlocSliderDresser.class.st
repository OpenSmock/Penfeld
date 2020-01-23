Class {
	#name : #PenBlocSliderDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocMarginStyle',
	#classTraits : 'TPenBlocMarginStyle classTrait',
	#instVars : [
		'progression',
		'cursorSize',
		'barSize',
		'sliderSize',
		'barPosition',
		'minX',
		'maxX',
		'originalPosition',
		'mouseInCursor'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocSliderDresser >> backgroundColor: aValue [
	| cursor |
	cursor := self component engineElement childNamed: #cursor.
	cursor background: aValue.
]

{ #category : #accessing }
PenBlocSliderDresser >> barSize [
	^ barSize
]

{ #category : #styling }
PenBlocSliderDresser >> border: aValue [
	| borderBuilder |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property value isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property value isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property value isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	(self component engineElement childNamed: #cursor) border: borderBuilder build.
]

{ #category : #styling }
PenBlocSliderDresser >> color: aValue [ 
	| bar |
	bar := self component engineElement childNamed: #bar.
	bar background: aValue.
]

{ #category : #rendering }
PenBlocSliderDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement height: var pref ]
]

{ #category : #dressing }
PenBlocSliderDresser >> doBeforeApplyStyle [
	| cursor x bx by |
	
	bx := barSize x.
	by := barSize y.
	
	self component width ifNotNil: [ bx := self component width pref ].
	self component height ifNotNil: [ by := self component height pref ].
	
	barSize := bx @ by.
	
	x := (self component fraction * barSize x) asInteger.
	cursor := self component engineElement childNamed: #cursor.
	cursor relocate: x @ 0
]

{ #category : #dressing }
PenBlocSliderDresser >> initEngineElement [
	| bar |
	cursorSize := 8@15.
	barSize := 200@5.
	sliderSize := (barSize x + cursorSize x) @ cursorSize y.
	barPosition := (cursorSize x / 2) @ ((sliderSize y - barSize y) / 2).
	
	bar := (BlRectangle new extent: barSize) asElement.
	bar relocate: barPosition.
	bar border: BlBorder empty.
	
	self component engineElement: BlElement new.
	self component engineElement size: sliderSize.
	self component engineElement addChild: bar as: #bar.
	self component engineElement addChild: (BlRectangle new extent: 8@15 ) asElement as: #cursor.
	
	minX := 0.
	maxX := self component dresser barSize x.
	self component engineElement when: BlDragStartEvent do: [ :e | self whenDragStartEvent: e ].
	self component engineElement when: BlDragEvent do: [ :e | self whenDragEvent: e ].
	self component engineElement when: BlDragEndEvent do: [ :e | self whenDragEndEvent: e ].

]

{ #category : #events }
PenBlocSliderDresser >> whenDragEndEvent: anEvent [
	anEvent consumed: true
]

{ #category : #events }
PenBlocSliderDresser >> whenDragEvent: anEvent [
	| dragPosition x fraction |
	dragPosition := anEvent currentTarget globalPointToParent: anEvent position.
	
	x := dragPosition x - originalPosition x - mouseInCursor x.
	x := x max: minX.
	x := x min: maxX.
	
	fraction := (x - minX) / (maxX - minX).
	self component ifNotNil: [ self component updateFraction: fraction ].
	
	anEvent consumed: true
]

{ #category : #events }
PenBlocSliderDresser >> whenDragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	mouseInCursor := (anEvent currentTarget childNamed: #cursor) globalPointToLocal: anEvent position.

	"element position in parent"
	originalPosition := anEvent currentTarget position.
]
