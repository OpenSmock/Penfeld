Class {
	#name : #PenBlocShapeDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocSizeStyle + TPenBlocMarginStyle + TPenBlocBackgroundStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocSizeStyle classTrait + TPenBlocMarginStyle classTrait + TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocShapeDresser >> doAfterApplyStyle [ 
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
]

{ #category : #dressing }
PenBlocShapeDresser >> initEngineElement [
	| element |
	element := self component shape asBlElement.
	element
		border: BlBorder empty;
		background: BlBackground transparent.
	
	self component hasEvents ifFalse: [ element preventMeAndChildrenMouseEvents ].
	
	self component engineElement: element .
]
