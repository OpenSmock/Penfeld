Class {
	#name : #PenBlocTextEditorDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle + TPenBlocBorderStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait',
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Brick-TextEditor-Dressers'
}

{ #category : #accessing }
PenBlocTextEditorDresser >> dataSource [
	^dataSource
]

{ #category : #dressing }
PenBlocTextEditorDresser >> doAfterApplyStyle [
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
PenBlocTextEditorDresser >> initEngineElement [
	
	self component engineElement: BrEditorElement new.	
	dataSource := BrTextEditor new.
	
	self component engineElement editor: dataSource.
	self component engineElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
		
]
