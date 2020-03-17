Class {
	#name : #PenBlocShapeDresser,
	#superclass : #PenBlocDresser,
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

{ #category : #styling }
PenBlocShapeDresser >> font: aModel on: aComponent [
	"There is no text on shape"
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

{ #category : #dressing }
PenBlocShapeDresser >> initEngineElementFor: aComponent [
	| element |
	element := aComponent shape asBlElement.
	element
		border: BlBorder empty;
		background: BlBackground transparent.
	
	aComponent hasEvents ifFalse: [ element preventMeAndChildrenMouseEvents ].
	aComponent engineElement: element.
]

{ #category : #styling }
PenBlocShapeDresser >> text: aModel on: aComponent [
	"There is no text on shape"
]
