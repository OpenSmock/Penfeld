Class {
	#name : #PenBlocTextEditorDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait',
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Brick-TextEditor'
}

{ #category : #styling }
PenBlocTextEditorDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
PenBlocTextEditorDresser >> backgroundImage: aValue [

]

{ #category : #dressing }
PenBlocTextEditorDresser >> initEngineElement [
	|styler element|
	element := BrEditorElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	"element  background: Color white."
	
	dataSource := BrTextEditor new.

	self model engineElement: element.
	
	styler := BrRBTextStyler new.
	styler classOrMetaClass: Object.
	dataSource styler: styler.
	dataSource text: (BlRopedText string: 'myExample
	|col|
	col := OrderedCollection new.
	col add: (Random new next).
	col add: (Random new next).
	col add: (Random new next).
	^col shuffled').
	
	self model engineElement editor: dataSource.
	self component engineElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
		
]
