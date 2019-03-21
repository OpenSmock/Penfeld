Class {
	#name : #PenBlocProgressBarDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'extent'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocProgressBarDresser >> backgroundColor: aValue [
	| bar |
	bar := self model engineElement childNamed: #bar.
	bar background: aValue
]

{ #category : #styling }
PenBlocProgressBarDresser >> border: aValue [
	| progression |
	progression := self model engineElement childNamed: #progression.
		
	aValue do: 
	[ :property | 
		(property isKindOf: Color)
			ifTrue: [ progression background: property ] 
	].
]

{ #category : #rendering }
PenBlocProgressBarDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model engineElement width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model engineElement height: var pref ]
]

{ #category : #dressing }
PenBlocProgressBarDresser >> doBeforeApplyStyle [
	| progression |
	progression := self model engineElement childNamed: #progression.
	progression size: (extent x * self model fraction) asInteger @ extent y
]

{ #category : #dressing }
PenBlocProgressBarDresser >> initEngineElement [
	| bar progression |
	self model engineElement: BlElement new.
	extent := 200@5. 
	self model engineElement size: extent.
	
	bar := (BlRectangle new extent: extent) asElement.
	bar border: BlBorder empty.
	self model engineElement addChild: bar as: #bar.
	
	progression := (BlRectangle new extent: 
		(extent x * self model fraction) asInteger @ extent y) asElement.
	progression border: BlBorder empty.
	self model engineElement addChild: progression as: #progression.

]
