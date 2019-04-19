Class {
	#name : #PenBlocTextEditorExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocTextEditorExamples class >> exampleCodeEditor [
	| component |
	component := PenTextEditor new.
	component position: 0 @ 0.
	component width: 500.
	component height: 500.
	component dresser: PenBlocTextEditorDresser new.
	component openInWorld
]

{ #category : #'see class side' }
PenBlocTextEditorExamples >> seeClassSide [
]
