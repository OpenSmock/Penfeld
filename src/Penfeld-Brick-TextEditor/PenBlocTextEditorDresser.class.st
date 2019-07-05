Class {
	#name : #PenBlocTextEditorDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait',
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Brick-TextEditor-Dressers'
}

{ #category : #styling }
PenBlocTextEditorDresser >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #styling }
PenBlocTextEditorDresser >> backgroundImage: aValue [

]

{ #category : #accessing }
PenBlocTextEditorDresser >> dataSource [
	^dataSource
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
