Class {
	#name : #PenAbstractDresser,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Penfeld-Core'
}

{ #category : #dressing }
PenAbstractDresser >> dress [
	^ self subclassResponsibility 
]

{ #category : #dressing }
PenAbstractDresser >> initEngineElement [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenAbstractDresser >> model [ 
	^ model
]

{ #category : #accessing }
PenAbstractDresser >> model: aModel [
	model := aModel
]
