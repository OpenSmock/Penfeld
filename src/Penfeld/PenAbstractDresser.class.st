Class {
	#name : #PenAbstractDresser,
	#superclass : #Object,
	#instVars : [
		'model',
		'component'
	],
	#category : #'Penfeld-Abstracts'
}

{ #category : #accessing }
PenAbstractDresser >> component [ 
	^ component
]

{ #category : #accessing }
PenAbstractDresser >> component: aComponent [
	component := aComponent
]

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
	self deprecated: 'Use component instead'.
	^ component
]

{ #category : #accessing }
PenAbstractDresser >> model: aComponent [
	self deprecated: 'Use component: instead'.
	component := aComponent
]
