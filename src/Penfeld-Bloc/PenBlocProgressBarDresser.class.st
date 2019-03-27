Class {
	#name : #PenBlocProgressBarDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait',
	#instVars : [
		'extent'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocProgressBarDresser >> blocBarColor: aValue [
	(self model engineElement childNamed: #bar) background: aValue
]

{ #category : #styling }
PenBlocProgressBarDresser >> border: aValue [
	| progression |
	progression := self model engineElement childNamed: #bar.
		
	aValue do: 
	[ :property | 
		(property isKindOf: Color)
			ifTrue: [ progression background: property ] 
	].
]

{ #category : #rendering }
PenBlocProgressBarDresser >> doAfterApplyStyle [ 
	| var progression |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ extent := var pref @ extent y ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ extent := extent x @ var pref ].
	
	"Progression"
	self model engineElement size: extent.
	progression := self model engineElement childNamed: #bar.
	progression size: (extent x * self model fraction) asInteger @ extent y
]

{ #category : #dressing }
PenBlocProgressBarDresser >> doBeforeApplyStyle [
	| progression |
	progression := self model engineElement childNamed: #bar.
	progression size: (extent x * self model fraction) asInteger @ extent y
]

{ #category : #styling }
PenBlocProgressBarDresser >> height: aValue [
	extent := extent x @ aValue
]

{ #category : #dressing }
PenBlocProgressBarDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement addChild: BlElement new as: #bar.
	
	extent := 50@20.

]

{ #category : #styling }
PenBlocProgressBarDresser >> width: aValue [
	extent := aValue @ extent y 
]
