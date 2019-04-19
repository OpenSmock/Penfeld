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
	(self component engineElement childNamed: #bar) background: aValue
]

{ #category : #styling }
PenBlocProgressBarDresser >> border: aValue [
	| progression |
	progression := self component engineElement childNamed: #bar.
		
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
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ extent := var pref @ extent y ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ extent := extent x @ var pref ].
	
	"Progression"
	self component engineElement size: extent.
	progression := self component engineElement childNamed: #bar.
	progression size: (extent x * self component fraction) asInteger @ extent y
]

{ #category : #dressing }
PenBlocProgressBarDresser >> doBeforeApplyStyle [
	| progression size |
	progression := self component engineElement childNamed: #bar.
	size := (extent x * self component fraction) asInteger @ extent y.
	progression size: size
]

{ #category : #styling }
PenBlocProgressBarDresser >> height: aValue [
	extent := extent x @ aValue
]

{ #category : #dressing }
PenBlocProgressBarDresser >> initEngineElement [
	self component engineElement: BlElement new.
	self component engineElement addChild: BlElement new as: #bar.
	
	extent := 50@20.

]

{ #category : #styling }
PenBlocProgressBarDresser >> width: aValue [
	extent := aValue @ extent y 
]
