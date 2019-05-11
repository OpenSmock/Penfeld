Class {
	#name : #PenBlocShapeExperimentalDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocShapeExperimentalDresser >> initEngineElement [
	self component engineElement: self component shape asElement.
]
