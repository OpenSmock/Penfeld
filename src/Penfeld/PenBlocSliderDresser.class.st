Class {
	#name : #PenBlocSliderDresser,
	#superclass : #PenBlocDresser,
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
	cursor := self model interactor childNamed: #cursor.
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
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	(self model interactor childNamed: #cursor) border: borderBuilder build.
]

{ #category : #styling }
PenBlocSliderDresser >> color: aValue [ 
	| bar |
	bar := self model interactor childNamed: #bar.
	bar background: aValue.
]

{ #category : #rendering }
PenBlocSliderDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model interactor width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model interactor height: var pref ]
]

{ #category : #dressing }
PenBlocSliderDresser >> doBeforeApplyStyle [
	| cursor x |
	x := (self model fraction * barSize x) asInteger.
	cursor := self model interactor childNamed: #cursor.
	cursor relocate: x @ 0
]

{ #category : #dressing }
PenBlocSliderDresser >> initInteractor [
	| bar |
	cursorSize := 8@15.
	barSize := 200@5.
	sliderSize := (barSize x + cursorSize x) @ cursorSize y.
	barPosition := (cursorSize x / 2) @ ((sliderSize y - barSize y) / 2).
	
	bar := (BlRectangle new extent: barSize) asElement.
	bar relocate: barPosition.
	bar border: BlBorder empty.
	
	self model interactor: BlElement new.
	self model interactor size: sliderSize.
	self model interactor addChild: bar as: #bar.
	self model interactor addChild: (BlRectangle new extent: 8@15 ) asElement as: #cursor.
	
	minX := 0.
	maxX := self model dresser barSize x.
	self model interactor when: BlDragStartEvent do: [ :e | self whenDragStartEvent: e ].
	self model interactor when: BlDragEvent do: [ :e | self whenDragEvent: e ].
	self model interactor when: BlDragEndEvent do: [ :e | self whenDragEndEvent: e ].

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
	self model ifNotNil: [ self model updateFraction: fraction ].
	
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
