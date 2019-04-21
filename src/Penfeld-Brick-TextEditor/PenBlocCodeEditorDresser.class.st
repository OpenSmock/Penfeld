Class {
	#name : #PenBlocCodeEditorDresser,
	#superclass : #PenBlocTextEditorDresser,
	#instVars : [
		'styler',
		'behavior'
	],
	#category : #'Penfeld-Brick-TextEditor-Dressers'
}

{ #category : #'text - styling' }
PenBlocCodeEditorDresser >> behavior [
	^ behavior ifNil: [ behavior := Object ]
]

{ #category : #'text - styling' }
PenBlocCodeEditorDresser >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #dressing }
PenBlocCodeEditorDresser >> initEngineElement [
	super initEngineElement.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: self behavior.
	dataSource styler: styler
]
