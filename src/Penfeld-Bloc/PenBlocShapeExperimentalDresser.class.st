Class {
	#name : #PenBlocShapeExperimentalDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocSizeStyle + TPenBlocMarginStyle + TPenBlocBackgroundStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocSizeStyle classTrait + TPenBlocMarginStyle classTrait + TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocShapeExperimentalDresser >> doAfterApplyStyle [ 
	| var element |
	element := self component engineElement.

	"Position"
	var := self component position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ element width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ element height: var pref ].
	
	"Fill"
	var := self component fillColor.
	var ifNotNil: [ element background: var ].
	
	self flag: 'stroke to do'.
]

{ #category : #dressing }
PenBlocShapeExperimentalDresser >> initEngineElement [
	self component engineElement: (self component shape
		ifNil: [ BlElement new ]
		ifNotNil: [ self component shape ]).
		
	"Reinit BlElement values"
	self component engineElement border: BlBorder empty.
]
