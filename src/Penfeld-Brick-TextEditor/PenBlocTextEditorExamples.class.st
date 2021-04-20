Class {
	#name : #PenBlocTextEditorExamples,
	#superclass : #Object,
	#category : #'Penfeld-Brick-TextEditor-Examples'
}

{ #category : #examples }
PenBlocTextEditorExamples class >> exampleCodeEditor [
	| component |
	component := PenCodeEditor new.
	component position: 0 @ 0.
	component width: 500.
	component height: 500.
	component dresser: PenBlocCodeEditorDresser new.
	component behavior: OrderedCollection.
	component open
]

{ #category : #examples }
PenBlocTextEditorExamples class >> exampleTextEditor [
	| component |
	component := PenTextEditor new.
	component position: 0 @ 0.
	component width: 500.
	component height: 500.
	component dresser: PenBlocTextEditorDresser new.
	component open
]

{ #category : #'see class side' }
PenBlocTextEditorExamples >> seeClassSide [
]
