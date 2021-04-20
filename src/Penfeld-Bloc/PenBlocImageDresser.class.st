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

{ #category : #dressing }
PenBlocImageDresser >> doAfterApplyStyleOn: aComponent [
	| element width height position x y |
	
	element := aComponent engineElement.
	
	form ifNil: [ ^ self ].

	"Size"
	width := aComponent width ifNotNil: [ aComponent width pref ].
	width ifNil: [ width := form width ].
	height := aComponent height ifNotNil: [ aComponent height pref ].
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
	position := aComponent position.
	position ifNotNil: [ element relocate: position ].	
	
	element constraintsDo: [ :c | 
		c horizontal exact: width.
		c vertical exact: height ].	
]

{ #category : #dressing }
PenBlocImageDresser >> doBeforeApplyStyleOn: aComponent [
	form := aComponent form copy.
]

{ #category : #dressing }
PenBlocImageDresser >> initEngineElementFor: aComponent [
	aComponent engineElement: (BlElement new addChild: BlElement new as: #image).
	aComponent hasEvents ifFalse: [ aComponent engineElement preventMeAndChildrenMouseEvents ].
]

{ #category : #styling }
PenBlocImageDresser >> text: aModel on: aComponent [
	"do nothing here"
	
]
