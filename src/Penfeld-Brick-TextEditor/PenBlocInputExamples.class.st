Class {
	#name : #PenBlocInputExamples,
	#superclass : #Object,
	#category : #'Penfeld-Brick-TextEditor-Examples'
}

{ #category : #examples }
PenBlocInputExamples class >> exampleInput [
	| component |
	component := PenInput new.
	component position: 0 @ 0.
	component width: 200.
	component height: 50.
	component dresser: PenBlocInputDresser new.
	component openInWorld
]

{ #category : #'see class side' }
PenBlocInputExamples >> seeClassSide [ 
]
