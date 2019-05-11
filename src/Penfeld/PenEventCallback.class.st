Class {
	#name : #PenEventCallback,
	#superclass : #Object,
	#category : #'Penfeld-Events'
}

{ #category : #private }
PenEventCallback >> executeCallback [
	^ self subclassResponsibility 
]

{ #category : #private }
PenEventCallback >> executeCallback: anEvent [
	^ self subclassResponsibility 
]
