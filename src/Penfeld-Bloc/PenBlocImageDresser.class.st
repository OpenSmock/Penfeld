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

{ #category : #styling }
PenBlocImageDresser >> color: aValue [
	form := form repaintWith: aValue value.
]

{ #category : #dressing }
PenBlocImageDresser >> doAfterApplyStyle [ 
	| var element |
	
	element := self component engineElement.

	"Position"
	var := self component position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ form := form scaledToSize: var pref @ form height ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ form := form scaledToSize: form width @ var pref ].
		
	element constraintsDo: [ :c | 
		c horizontal exact: form width.
		c vertical exact: form height ].	
	
	"Apply form"
	element background: form asBlBackground.
]

{ #category : #dressing }
PenBlocImageDresser >> doBeforeApplyStyle [ 
	form := self component form copy.
]

{ #category : #dressing }
PenBlocImageDresser >> initEngineElement [
	self component engineElement: BlElement new.
	self component hasEvents ifFalse: [ self component engineElement preventMeAndChildrenMouseEvents ].
]

{ #category : #styling }
PenBlocImageDresser >> maxHeight: aValue [
	maxHeight := aValue value.
]

{ #category : #styling }
PenBlocImageDresser >> maxWidth: aValue [
	maxWidth := aValue value.
]
