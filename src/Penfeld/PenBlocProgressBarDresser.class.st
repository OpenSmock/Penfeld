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
	bar := self model interactor childNamed: #bar.
	bar background: aValue
]

{ #category : #styling }
PenBlocProgressBarDresser >> border: aValue [
	| progression |
	progression := self model interactor childNamed: #progression.
		
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
	var ifNotNil: [ self model interactor relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model interactor width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model interactor height: var pref ]
]

{ #category : #dressing }
PenBlocProgressBarDresser >> doBeforeApplyStyle [
	| progression |
	progression := self model interactor childNamed: #progression.
	progression size: (extent x * self model fraction) asInteger @ extent y
]

{ #category : #dressing }
PenBlocProgressBarDresser >> initInteractor [
	| bar progression |
	self model interactor: BlElement new.
	extent := 200@5. 
	self model interactor size: extent.
	
	bar := (BlRectangle new extent: extent) asElement.
	bar border: BlBorder empty.
	self model interactor addChild: bar as: #bar.
	
	progression := (BlRectangle new extent: 
		(extent x * self model fraction) asInteger @ extent y) asElement.
	progression border: BlBorder empty.
	self model interactor addChild: progression as: #progression.

]
